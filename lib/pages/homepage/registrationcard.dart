import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class registrationcard extends StatelessWidget {
  const registrationcard({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(

              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFF2E4B82),
                borderRadius: BorderRadius.circular(12),
              ),
            
                
                child: ListTile(

                  
                  
                    
                      trailing:  Icon(Icons.note_add_sharp, color: Colors.white, size: 30),
                        title: 
                          Text(
                            'طلب التسجيل',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        subtitle:   Text(
                        "لا يوجد طلبات نشطه",   
                        style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          leading: SvgPicture.asset("assets/imgs/whitechair.svg"),
                        
                      
                    
                    
                  ),
    );
  
}}