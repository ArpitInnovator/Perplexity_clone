import cohere
from config import Settings
import numpy as np

settings = Settings()

class cohereService:
    def __init__(self):
        self.client = cohere.Client(api_key=settings.COHERE_API_KEY)
        self.model = "embed-english-light-v3.0"
    
    def get_embeddings(self, texts):
        """Get embeddings for a list of texts using Cohere embed-english-light-v3.0"""
        try:
            # Process texts in batches to avoid rate limits
            batch_size = 10
            all_embeddings = []
            
            for i in range(0, len(texts), batch_size):
                batch = texts[i:i + batch_size]
                
                # Get embeddings for the batch using Cohere API
                response = self.client.embed(
                    texts=batch,
                    model=self.model,
                    input_type="search_document" if i > 0 else "search_query"
                )
                batch_embeddings = response.embeddings
                all_embeddings.extend(batch_embeddings)
            
            return all_embeddings
            
        except Exception as e:
            print(f"Error getting embeddings: {e}")
            # Return random embeddings as fallback (384 dimensions for embed-english-light-v3.0)
            return [np.random.rand(384).tolist() for _ in texts]
    
    def calculate_similarity(self, query_embedding, text_embeddings):
        """Calculate cosine similarity between query and text embeddings"""
        similarities = []
        query_vec = np.array(query_embedding)
        
        for text_embedding in text_embeddings:
            text_vec = np.array(text_embedding)
            
            # Cosine similarity
            dot_product = np.dot(query_vec, text_vec)
            norm_query = np.linalg.norm(query_vec)
            norm_text = np.linalg.norm(text_vec)
            
            if norm_query == 0 or norm_text == 0:
                similarity = 0
            else:
                similarity = dot_product / (norm_query * norm_text)
            
            similarities.append(similarity)
        
        return similarities