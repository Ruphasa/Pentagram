import 'package:flutter/material.dart';

class Notifikasi extends StatelessWidget {
  const Notifikasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with back button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.blue,
                      size: 28,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Notifikasi',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            
            // Empty state
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Mailbox illustration
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Decorative stars
                          Positioned(
                            top: 30,
                            left: 50,
                            child: Icon(
                              Icons.star,
                              color: Colors.blue.withOpacity(0.3),
                              size: 16,
                            ),
                          ),
                          Positioned(
                            top: 50,
                            right: 40,
                            child: Icon(
                              Icons.star,
                              color: Colors.blue.withOpacity(0.3),
                              size: 12,
                            ),
                          ),
                          Positioned(
                            bottom: 40,
                            right: 50,
                            child: Icon(
                              Icons.star,
                              color: Colors.blue.withOpacity(0.3),
                              size: 14,
                            ),
                          ),
                          // Mailbox icon
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.purple.shade400,
                                  Colors.pink.shade400,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Stack(
                              children: [
                                const Center(
                                  child: Icon(
                                    Icons.mail_outline,
                                    size: 60,
                                    color: Colors.white,
                                  ),
                                ),
                                // Flag on mailbox
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Container(
                                    width: 8,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade400,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Container(
                                    width: 20,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade400,
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(2),
                                        bottomRight: Radius.circular(2),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Envelope icon
                          Positioned(
                            left: 20,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.mail,
                                color: Colors.grey,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Belum Ada Notifikasi',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text(
                        'Belum ada notifikasi saat ini. Semua notifikasi yang kami kirim akan muncul di sini!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}