import 'package:flutter/material.dart';
import 'package:perplexity_clone/services/chat_web_service.dart';
import 'package:perplexity_clone/theme/colors.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

class SourcesSection extends StatefulWidget {
  const SourcesSection({super.key});

  @override
  State<SourcesSection> createState() => _SourcesSectionState();
}

class _SourcesSectionState extends State<SourcesSection> {
  bool isLoading = false;
  List searchResults = [
    {
      'title': 'Loading...',
      'url':
          'Loading...',
    },
    {
      'title': 'Loading...',
      'url':
          'Loading...',
    },
    {
      'title': 'Loading...',
      'url':
          'Loading...',
    }
  ];

  // Add this method to launch URLs
  Future<void> _launchURL(String url) async {
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }
    
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // Show error message if URL can't be launched
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch $url')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    ChatWebService().searchResultStream.listen((data){
      setState(() {
        searchResults = data['data'];
        isLoading = false;
      },
      );
    },
    );

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Row(
        children: [
        Icon(Icons.source_outlined, color: Colors.white70,),
        SizedBox(width: 8),
        Text('Sources', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
      ),
      const SizedBox(height: 16),

      Skeletonizer(
        enabled: isLoading,
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          children: searchResults.map((res) {
            return GestureDetector( // Wrap with GestureDetector
              onTap: () => _launchURL(res['url']), // Add tap handler
              child: Container(
                width: 150,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.cardColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all( // Add border to indicate it's clickable
                    color: Colors.grey.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                   res['title'],
                   style: TextStyle (
                    fontWeight: FontWeight.w500,
                   ),
                   maxLines: 2,
                   overflow: TextOverflow.ellipsis,
                    ),
                   const SizedBox(height: 8),
                   Text(
                    res['url'],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                   ),
                  ]
              ),
               ),
            );
          }).toList(),
        ),
      )
    ],
    );
  }
}