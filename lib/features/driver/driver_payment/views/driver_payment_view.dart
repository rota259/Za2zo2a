import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/network/api_error.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../injection_container.dart';
import '../../data/driver_repo.dart';

class DriverPaymentView extends StatefulWidget {
  const DriverPaymentView({super.key});

  @override
  State<DriverPaymentView> createState() => _DriverPaymentViewState();
}

class _DriverPaymentViewState extends State<DriverPaymentView> {
  final _walletCtrl = TextEditingController();
  final _holderCtrl = TextEditingController();
  final _bankNameCtrl = TextEditingController();
  final _swiftCtrl = TextEditingController();
  final _ibanCtrl = TextEditingController();

  bool _loading = true;
  bool _savingWallet = false;
  bool _savingBank = false;
  double _balance = 0;
  String _currency = 'EGP';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _loading = true);
    final repo = sl<DriverRepo>();
    try {
      final bal = await repo.getBalance();
      if (!mounted) return;
      setState(() {
        _balance = bal.pendingBalance;
        _currency = bal.currency.isNotEmpty ? bal.currency : 'EGP';
        _loading = false;
      });
    } on ApiError {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _saveWallet() async {
    final text = _walletCtrl.text.trim();
    if (text.isEmpty) {
      _snack('Enter a wallet number');
      return;
    }
    final ok = await _confirm('Save wallet number "$text"?');
    if (!ok) return;

    setState(() => _savingWallet = true);
    try {
      await sl<DriverRepo>().saveWallet({'walletNumber': text});
      _snack('Wallet saved', success: true);
    } on ApiError catch (e) {
      _snack(e.message);
    } finally {
      if (mounted) setState(() => _savingWallet = false);
    }
  }

  Future<void> _saveBank() async {
    final holder = _holderCtrl.text.trim();
    final iban = _ibanCtrl.text.trim();
    if (holder.isEmpty || iban.isEmpty) {
      _snack('Name and IBAN are required');
      return;
    }
    final ok = await _confirm('Save bank details for $holder?');
    if (!ok) return;

    setState(() => _savingBank = true);
    try {
      await sl<DriverRepo>().saveBank({
        'holderName': holder,
        'bankName': _bankNameCtrl.text.trim(),
        'swiftCode': _swiftCtrl.text.trim(),
        'iban': iban,
      });
      _snack('Bank details saved', success: true);
    } on ApiError catch (e) {
      _snack(e.message);
    } finally {
      if (mounted) setState(() => _savingBank = false);
    }
  }

  Future<bool> _confirm(String msg) async {
    return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Confirm'),
            content: Text(msg),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(ctx, false),
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () => Navigator.pop(ctx, true),
                  child: const Text('Save')),
            ],
          ),
        ) ??
        false;
  }

  void _snack(String msg, {bool success = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(msg),
          backgroundColor: success ? Colors.green : null),
    );
  }

  @override
  void dispose() {
    _walletCtrl.dispose();
    _holderCtrl.dispose();
    _bankNameCtrl.dispose();
    _swiftCtrl.dispose();
    _ibanCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('ZA2ZO2A',
            style: TextStyle(
                color: const Color(0xFFC2185B),
                fontWeight: FontWeight.w900,
                fontSize: context.fontPct(16),
                letterSpacing: 1.2)),
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: context.widthPct(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: context.heightPct(24)),
                  Text('Payment Settings',
                      style: AppTextStyles.h2(context)
                          .copyWith(fontWeight: FontWeight.w900)),
                  SizedBox(height: context.heightPct(20)),

                  // ── Balance ──
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(context.widthPct(20)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.pink.shade100),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2)),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('CURRENT BALANCE',
                            style: TextStyle(
                                fontSize: 10,
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0)),
                        SizedBox(height: 8),
                        Text('$_currency ${_balance.toStringAsFixed(2)}',
                            style: AppTextStyles.h1(context)
                                .copyWith(fontWeight: FontWeight.w900)),
                      ],
                    ),
                  ),
                  SizedBox(height: context.heightPct(32)),

                  // ── Wallet ──
                  _sectionTitle('E-Wallet'),
                  SizedBox(height: context.heightPct(12)),
                  _card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: const Color(0xFFE91E63),
                                borderRadius: BorderRadius.circular(10)),
                            child: Icon(Icons.account_balance_wallet,
                                color: Colors.white, size: 20),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Meza Wallet',
                                    style: AppTextStyles.bodyMedium(context)
                                        .copyWith(fontWeight: FontWeight.bold)),
                                Text('Instant Digital Payouts',
                                    style: TextStyle(
                                        color: AppColors.textSecondary,
                                        fontSize: 10)),
                              ],
                            ),
                          ),
                        ]),
                        SizedBox(height: 16),
                        _label('WALLET NUMBER'),
                        _input(_walletCtrl, 'Enter wallet number'),
                        SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE91E63),
                              padding: EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            onPressed: _savingWallet ? null : _saveWallet,
                            child: _savingWallet
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2, color: Colors.white))
                                : Text('SAVE WALLET',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: context.heightPct(16)),

                  // ── Bank Account ──
                  _sectionTitle('Bank Account'),
                  SizedBox(height: context.heightPct(12)),
                  _card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: AppColors.grey100,
                                borderRadius: BorderRadius.circular(10)),
                            child: Icon(Icons.account_balance,
                                color: AppColors.textPrimary, size: 20),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Bank Transfer',
                                    style: AppTextStyles.bodyMedium(context)
                                        .copyWith(fontWeight: FontWeight.bold)),
                                Text('2-3 Business Days',
                                    style: TextStyle(
                                        color: AppColors.textSecondary,
                                        fontSize: 10)),
                              ],
                            ),
                          ),
                        ]),
                        SizedBox(height: 24),
                        _label('ACCOUNT HOLDER NAME'),
                        _input(_holderCtrl, 'Full name'),
                        SizedBox(height: 16),
                        _label('BANK NAME'),
                        _input(_bankNameCtrl, 'e.g. CIB, NBE'),
                        SizedBox(height: 16),
                        _label('SWIFT / BIC'),
                        _input(_swiftCtrl, 'SWIFT code'),
                        SizedBox(height: 16),
                        _label('ACCOUNT NUMBER / IBAN'),
                        _input(_ibanCtrl, 'IBAN or account number'),
                        SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE91E63),
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            onPressed: _savingBank ? null : _saveBank,
                            child: _savingBank
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2, color: Colors.white))
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.lock_outline,
                                          color: Colors.white, size: 16),
                                      SizedBox(width: 8),
                                      Text('SAVE BANK DETAILS',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1.0)),
                                    ],
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: context.heightPct(24)),

                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Colors.pink.shade50,
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.security,
                            color: const Color(0xFFE91E63), size: 20),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Your financial data is encrypted and securely transmitted to the server.',
                            style:
                                TextStyle(fontSize: 10, color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: context.heightPct(40)),
                ],
              ),
            ),
    );
  }

  Widget _sectionTitle(String text) => Text(text,
      style:
          AppTextStyles.h3(context).copyWith(fontWeight: FontWeight.bold));

  Widget _card({required Widget child}) => Container(
        padding: EdgeInsets.all(context.widthPct(16)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.grey200),
        ),
        child: child,
      );

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Text(text,
            style: TextStyle(
                fontSize: 9,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0)),
      );

  Widget _input(TextEditingController ctrl, String hint) => TextField(
        controller: ctrl,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
              color: Colors.black38, fontWeight: FontWeight.bold, fontSize: 14),
          filled: true,
          fillColor: AppColors.grey50,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none),
        ),
      );
}
