from services.groq_service import GroqService
import numpy as np

class SortSourceService:
    def __init__(self):
        self.groq_service = GroqService()
    
    def sort_sources(self, query: str, search_results: list[dict]):
        """Sort search results by relevance to query using Groq embeddings"""
        if not search_results:
            return []
        
        try:
            # Get embeddings for query and all search results
            texts = [result['content'] for result in search_results]
            query_texts = [query]
            
            # Get embeddings
            query_embeddings = self.groq_service.get_embeddings(query_texts)
            text_embeddings = self.groq_service.get_embeddings(texts)
            
            # Calculate similarities
            similarities = self.groq_service.calculate_similarity(
                query_embeddings[0], text_embeddings
            )
            
            # Sort results by similarity score
            sorted_results = []
            for i, result in enumerate(search_results):
                result['similarity_score'] = similarities[i]
                sorted_results.append(result)
            
            # Sort by similarity score (highest first)
            sorted_results.sort(key=lambda x: x['similarity_score'], reverse=True)
            
            # Remove similarity score from final output
            for result in sorted_results:
                result.pop('similarity_score', None)
            
            return sorted_results
            
        except Exception as e:
            print(f"Error sorting sources: {e}")
            # Return original results if sorting fails
            return search_results