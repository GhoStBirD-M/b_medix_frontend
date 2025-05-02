import '../widgets/doctor/recive_message.dart';
import '../widgets/doctor/sent_message.dart';
import 'package:flutter/material.dart';

class DoctorChatScreen extends StatelessWidget {
  const DoctorChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Chat Header
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey, width: 0.5),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD5E8E6),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Chat',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD5E8E6),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Icon(Icons.more_horiz, color: Colors.black),
                  ),
                ],
              ),
            ),

            // Doctor Info
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/doctor2.png'),
                    child: Icon(Icons.person, color: Colors.grey),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Dr. James Patel',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Mental Psychologist',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD5E8E6),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Icon(Icons.videocam, color: Colors.black),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD5E8E6),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Icon(Icons.phone, color: Colors.black),
                  ),
                ],
              ),
            ),

            const Divider(),

            // Chat Messages
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  // Received Message
                  const ReceivedMessage(
                    message: 'Hey there! 👋',
                    time: '10:10',
                  ),

                  const ReceivedMessage(
                    message:
                        'This is your delivery driver from Speedy Chow. I\'m just around the corner from your place. 😊',
                    time: '10:10',
                  ),

                  // Sent Message
                  const SentMessage(
                    message: 'Hi!',
                    time: '10:10',
                    isRead: true,
                  ),

                  const SentMessage(
                    message:
                        'Awesome, thanks for letting me know! Can\'t wait for my delivery. 🍕',
                    time: '10:11',
                    isRead: true,
                  ),

                  const ReceivedMessage(
                    message:
                        'No problem at all!\nI\'ll be there in about 15 minutes.',
                    time: '10:11',
                  ),

                  const ReceivedMessage(
                    message: 'I\'ll text you when I arrive.',
                    time: '10:11',
                  ),

                  const SentMessage(
                    message: 'Great! 😊',
                    time: '10:12',
                    isRead: true,
                  ),
                ],
              ),
            ),

            // Message Input
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, -1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Type a message ...',
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.camera_alt,
                              color: Colors.grey,
                            ),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.attach_file,
                              color: Colors.grey,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Icon(Icons.mic, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
