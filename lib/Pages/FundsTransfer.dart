import 'package:app_bank/model/countries.dart';
import 'package:app_bank/utils/widgets.dart';
import 'package:flutter/material.dart';

class FundsTransfer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          'My Cash',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        children: <Widget>[
          Card(
            elevation: 10,
            child: ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AccountTransferOptions()));
              },
              isThreeLine: true,
              leading: menuCard(Icons.compare_arrows),
              title: Text(
                'ACCOUNT TRANSFER',
                style: Theme.of(context).textTheme.body2,
              ),
              subtitle: Text(
                'Transfer funds to other account',
                style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
              ),
            ),
          ),
          Card(
            elevation: 10,
            child: ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AccountTransfer()));
              },
              isThreeLine: true,
              leading: menuCard(Icons.arrow_upward),
              title: Text(
                'BANK TRANSFER',
                style: Theme.of(context).textTheme.body2,
              ),
              subtitle: Text(
                'Transfer funds to bank',
                style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),              ),
            ),
          ),
          Card(
            elevation: 10,
            child: ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MpesaTransfer()));
              },
              isThreeLine: true,
              leading: menuCard(Icons.credit_card),
              title: Text(
                'MPESA',
                style: Theme.of(context).textTheme.body2,
              ),
              subtitle: Text(
                  'Withdraw cash to M-Pesa',
                style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
              ),
            ),
          ),
          Card(
            elevation: 10,
            child: ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PayBills()));
              },
              isThreeLine: true,
              leading: menuCard(Icons.reorder),
              title: Text(
                'PAY BILLS',
                style: Theme.of(context).textTheme.body2,
              ),
              subtitle: Text(
                'Pay Bill from account',
                style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class AccountTransferOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Card(
            elevation: 10,
            child: ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AccountTransfer()));
              },
              isThreeLine: true,
              leading: menuCard(Icons.attach_money),
              title: Text(
                'OWN ACCOUNT TRANSFER',
                style: Theme.of(context).textTheme.body1,
              ),
              subtitle: Text(
                'Transfer funds to own account',
                style: Theme.of(context).textTheme.body2,
              ),
            ),
          ),
          Card(
            elevation: 10,
            child: ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AccountTransfer()));
              },
              isThreeLine: true,
              leading: menuCard(Icons.attach_money),
              title: Text(
                'OTHER ACCOUNT TRANSFER',
                style: Theme.of(context).textTheme.body1,
              ),
              subtitle: Text(
                'Transfer funds to other account',
                style: Theme.of(context).textTheme.body2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AccountTransfer extends StatefulWidget {
  @override
  _AccountTransferState createState() => _AccountTransferState();
}

class _AccountTransferState extends State<AccountTransfer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Account Transfer",
          style: Theme.of(context).appBarTheme.textTheme.display2,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 22, top: 8),
            child: Text(
              'Source Account Number',
              style: Theme.of(context).textTheme.display2,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 8),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 22, top: 8),
            child: Text(
              'Destination Account Number',
              style: Theme.of(context).textTheme.display2,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 8),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ),
          SizedBox.expand(
            child: getOutlineButton(
                "PROCEED", () {}, Theme.of(context).textTheme.subtitle),
          ),
        ],
      ),
    );
  }
}

class MpesaTransfer extends StatefulWidget {
  @override
  _MpesaTransferState createState() => _MpesaTransferState();
}

class _MpesaTransferState extends State<MpesaTransfer> {
  TextEditingController _phoneNumberController = TextEditingController();
  List<Country> countries = [];
  double _height, _fixedPadding;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _fixedPadding = _height * 0.025;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mpesa Transfer",
          style: Theme.of(context).appBarTheme.textTheme.display2,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 22, top: 8),
            child: Text(
              'Source Account Number',
              style: Theme.of(context).textTheme.display2,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 8),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 22, top: 8),
            child: Text(
              'M-Pesa Phone Number',
              style: Theme.of(context).textTheme.display2,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: _fixedPadding,
                right: _fixedPadding,
                bottom: _fixedPadding),
            child: Widgets.phoneNumberField(
                _phoneNumberController,
                "+254",
                Theme.of(context).textTheme.subtitle,
                Theme.of(context).textTheme.subtitle),
          ),
          getOutlineButton(
              "PROCEED", () {}, Theme.of(context).textTheme.subtitle),
        ],
      ),
    );
  }
}

class PayBills extends StatefulWidget {
  @override
  _PayBillsState createState() => _PayBillsState();
}

class _PayBillsState extends State<PayBills> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pay Bills",
          style: Theme.of(context).appBarTheme.textTheme.display2,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 22, top: 8),
            child: Text(
              'Source Account Number',
              style: Theme.of(context).textTheme.display2,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 8),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 22, top: 8),
            child: Text(
              'Paybill Number',
              style: Theme.of(context).textTheme.display2,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 8),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ),
          getOutlineButton(
              "PROCEED", () {}, Theme.of(context).textTheme.subtitle),
        ],
      ),
    );
  }
}
