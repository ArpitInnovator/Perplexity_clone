import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../widgets/side_bar.dart';
import '../widgets/search_section.dart';
import '../theme/colors.dart';
import '../services/chat_web_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 
  @override
  void initState() {
    super.initState();
    ChatWebService().connect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          kIsWeb ? SideBar() : SizedBox(),  // Sidebar
          Expanded(
            child: Padding(
              padding: !kIsWeb ? EdgeInsets.all(8.0) : EdgeInsets.zero,
              child: Column(
                children: [
                  Expanded(
                    child: SearchSection() // Search Section
                    ),
                   
              // Footer
                  Container(
                    padding: EdgeInsets.symmetric( vertical: 16),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'Pro',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.footerGrey,
                            ),
                          ),
                        ),
              
                         Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'Enterprise',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.footerGrey,
                            ),
                          ),
                        ),
              
                         Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'Store',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.footerGrey,
                            ),
                          ),
                        ),
              
                         Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'Blog',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.footerGrey,
                            ),
                          ),
                        ),
              
                         Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'Careers',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.footerGrey,
                            ),
                          ),
                        ),
              
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'English(English)',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.footerGrey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  
                ],
              ),
            ),
          ),



        ],
      ),
    );
  }
}
