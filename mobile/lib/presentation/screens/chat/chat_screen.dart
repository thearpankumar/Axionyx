import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/common/glass_card.dart';
import '../../../services/ai/groq_service.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  bool _isConfigured = false;

  @override
  void initState() {
    super.initState();
    _initializeGroq();
  }

  Future<void> _initializeGroq() async {
    await groqService.initialize();
    setState(() {
      _isConfigured = groqService.client != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Assistant'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              _showApiKeyDialog(context);
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF000000), // Pure Black
        ),
        child: SafeArea(
          child: Column(
            children: [
              // API key status
              if (!_isConfigured)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12.0),
                  color: Colors.orange.shade800,
                  child: const Row(
                    children: [
                      Icon(Icons.warning_amber_rounded, color: Colors.white),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Groq API key not configured. Tap the settings icon to add your API key.',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),

              // Chat messages list
              Expanded(
                child: _messages.isEmpty
                    ? const Center(
                        child: Text(
                          'Start a conversation with the AI assistant',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          return _buildMessage(_messages[index]);
                        },
                      ),
              ),

              // Input area
              _buildInputArea(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessage(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment:
            message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              margin: const EdgeInsets.only(
                left: 8.0,
                right: 8.0,
              ),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: message.isMe
                    ? Theme.of(context).colorScheme.primary
                    : const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16.0),
                  topRight: const Radius.circular(16.0),
                  bottomLeft: Radius.circular(message.isMe ? 16.0 : 4.0),
                  bottomRight: Radius.circular(message.isMe ? 4.0 : 16.0),
                ),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: message.isMe
                      ? Colors.white
                      : Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GlassCard(
        color: const Color(0xFF0A0A0A), // Match black theme
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _textController,
                enabled: _isConfigured,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: _isConfigured
                      ? 'Type your message...'
                      : 'Configure API key to send messages',
                  hintStyle: TextStyle(
                      color: _isConfigured ? Colors.white54 : Colors.white38),
                  border: InputBorder.none,
                ),
                onSubmitted: _isConfigured && !_isLoading ? _sendMessage : null,
              ),
            ),
            IconButton(
              icon: Icon(
                _isLoading ? Icons.hourglass_empty : Icons.send,
                color: _isConfigured && !_isLoading
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey,
              ),
              onPressed: _isConfigured && !_isLoading
                  ? () => _sendMessage(_textController.text)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage(String text) async {
    if (text.trim().isEmpty || _isLoading || !_isConfigured) return;

    final userMessage = ChatMessage(text: text.trim(), isMe: true);
    setState(() {
      _messages.add(userMessage);
      _textController.clear();
    });

    // Scroll to bottom
    _scrollToBottom();

    setState(() {
      _isLoading = true;
    });

    try {
      // Add a temporary "thinking" message
      final thinkingMessage = ChatMessage(text: "Thinking...", isMe: false);
      setState(() {
        _messages.add(thinkingMessage);
      });
      _scrollToBottom();

      // Call Groq API
      final chatCompletion = await groqService.client!.sendMessage(text.trim());

      final aiResponse = chatCompletion.choices.first.message.content;

      // Remove the "thinking" message and add the actual response
      setState(() {
        _messages.removeLast();
        _messages.add(ChatMessage(text: aiResponse, isMe: false));
      });
      _scrollToBottom();
    } catch (e) {
      // Remove the "thinking" message and add an error message
      setState(() {
        _messages.removeLast();
        _messages.add(ChatMessage(
            text:
                "Sorry, I couldn't process your request. Please check your API key and try again.",
            isMe: false));
      });
      _scrollToBottom();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _showApiKeyDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Configure Groq API Key'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Enter your Groq API key to enable AI chat functionality.',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: 'API Key',
                  hintText: 'Enter your Groq API key',
                ),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (controller.text.isNotEmpty) {
                  final navigator = Navigator.of(context);
                  final messenger = ScaffoldMessenger.of(context);

                  try {
                    await groqService.setApiKey(controller.text);
                    if (mounted) {
                      setState(() {
                        _isConfigured = true;
                      });

                      navigator.pop();
                      messenger.showSnackBar(
                        const SnackBar(
                          content: Text('API key configured successfully!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  } catch (e) {
                    if (mounted) {
                      messenger.showSnackBar(
                        SnackBar(
                          content: Text('Error configuring API key: $e'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

class ChatMessage {
  final String text;
  final bool isMe;

  ChatMessage({required this.text, required this.isMe});
}
