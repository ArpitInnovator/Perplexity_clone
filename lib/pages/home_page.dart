import 'package:flutter/material.dart';
import '../widgets/side_bar.dart';
import '../widgets/search_section.dart';
import '../theme/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideBar(),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: SearchSection()
                  ),
            
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



        ],
      ),
    );
  }
}
