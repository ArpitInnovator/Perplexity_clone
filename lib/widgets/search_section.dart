import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perplexity_clone/pages/chat_page.dart';
import 'package:perplexity_clone/services/chat_web_service.dart';
import '../theme/colors.dart';
import 'search_bar_button.dart';

class SearchSection extends StatefulWidget {
  const SearchSection({super.key});

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  final queryController = TextEditingController();
  final FocusNode _focusNode = FocusNode(); // Add focus node

  @override
  void dispose() {
    queryController.dispose();
    _focusNode.dispose(); // Dispose focus node
    super.dispose();
  }

  // Add method to handle search
  void _performSearch() {
    final query = queryController.text.trim();
    if (query.isNotEmpty) {
      ChatWebService().chat(query);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ChatPage(question: query)
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Where Knowledge Begins',
          style: GoogleFonts.ibmPlexMono(
            fontSize: 40,
            fontWeight: FontWeight.w400,
            height: 1.2,
            letterSpacing: -0.5,
          )
        ),

        const SizedBox(height: 32),

        // Search Bar
        Container(
          width: 700,
          decoration: BoxDecoration(
            color: AppColors.searchBar,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.searchBarBorder, width: 1.5),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: queryController,
                  focusNode: _focusNode, // Add focus node
                  decoration: InputDecoration(
                    hintText: 'Search anything...',
                    hintStyle: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: 16,
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                  ),
                  onSubmitted: (value) {
                    // Handle Enter key press
                    _performSearch();
                  },
                  textInputAction: TextInputAction.search, // This shows search action on mobile
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SearchBarButton(icon: Icons.auto_awesome_outlined, text: 'Focus'),
                    const SizedBox(width: 12),
                    SearchBarButton(icon: Icons.add_circle_outline, text: 'Attach'),
                    const Spacer(),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: _performSearch, // Use the new method
                        child: Container(
                          padding: EdgeInsets.all(9),
                          decoration: BoxDecoration(
                            color: AppColors.submitButton,
                            borderRadius: BorderRadius.circular(40), 
                          ),
                          child: const Icon(Icons.arrow_forward, color: AppColors.searchBar, size: 16,)
                        ),
                      ),
                    ),
                  ]
                ),
              ),
            ]
          )
        ),
      ],
    );
  }
}