import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../widgets/common.dart';

class Checkout extends StatefulWidget {
  final int total;
  const Checkout({super.key, required this.total});
  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final form = GlobalKey<FormState>();
  bool complete = false;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(complete ? 'All good.' : 'The final little details'),
      automaticallyImplyLeading: !complete,
    ),
    body: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 550),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(28),
          child: complete
              ? Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(30),
                      decoration: const BoxDecoration(
                        color: lime,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check_rounded, size: 60),
                    ),
                    const SizedBox(height: 28),
                    const Text(
                      'Excellent taste.\nGreat choice.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'SpaceGrotesk',
                        fontSize: 38,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -1.5,
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Your demo order is complete.\nNo payment was taken and no shipment will be made.',
                      textAlign: TextAlign.center,
                      style: TextStyle(height: 1.6),
                    ),
                    const SizedBox(height: 30),
                    FilledButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const ArrowLabel('Keep discovering'),
                    ),
                  ],
                )
              : Form(
                  key: form,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Almost yours.',
                        style: TextStyle(
                          fontFamily: 'SpaceGrotesk',
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -1.3,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Try the checkout experience. This is a demo order; no payment information is needed.',
                        style: TextStyle(height: 1.5, color: Colors.black54),
                      ),
                      const SizedBox(height: 26),
                      field('Full name'),
                      const SizedBox(height: 16),
                      field('Email', email: true),
                      const SizedBox(height: 16),
                      field('Delivery address'),
                      const SizedBox(height: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total · shipping included'),
                          Text(
                            '\$${widget.total}',
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () {
                            if (form.currentState!.validate()) {
                              setState(() => complete = true);
                            }
                          },
                          child: const ArrowLabel('Place demo order'),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    ),
  );
  Widget field(String label, {bool email = false}) => TextFormField(
    keyboardType: email ? TextInputType.emailAddress : TextInputType.text,
    decoration: InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFE0DCD5)),
      ),
    ),
    validator: (v) {
      if (v == null || v.trim().isEmpty) {
        return 'Please enter your ${label.toLowerCase()}';
      }
      if (email && !RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(v.trim())) {
        return 'Enter a valid email address';
      }
      return null;
    },
  );
}
