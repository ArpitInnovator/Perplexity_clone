import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'dart:async';
import 'package:web_socket_client/web_socket_client.dart';

class ChatWebService {
  static final _instance = ChatWebService._internal();
  WebSocket? _socket ;

  factory ChatWebService() => _instance;
  ChatWebService._internal();

  final _searchResultController = StreamController<Map<String, dynamic>>();
  final _contentController = StreamController<Map<String, dynamic>>();

  Stream<Map<String, dynamic>> get searchResultStream => _searchResultController.stream;
  Stream<Map<String, dynamic>> get contentStream => _contentController.stream;

  void connect() {
    final uri = Uri.parse('wss://perplexity-clone-wpog.onrender.com/ws/chat');

    _socket = WebSocket(uri);

    _socket!.messages.listen((message){
      final data = json.decode(message);
      if(data['type'] == 'search_result') {
        _searchResultController.add(data);
      }
      else if(data['type'] == 'content') {
        _contentController.add(data);
      }
      print(data['type']);
    });
  }

  void chat(String query) {
    _socket!.send(json.encode({'query': query}));
  }
}