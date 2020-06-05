import 'package:app_bank/utils/widgets.dart';
import 'package:flutter/material.dart';

class LoanMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          'Loans',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        children: <Widget>[
          Card(
            elevation: 3,
            child: ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RequestLoan()));
              },
              title: Text(
                'Request a loan',
                style: Theme.of(context).textTheme.body2,
              ),
            ),
          ),
          Card(
            elevation: 3,
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OutstandingLoans()));
              },
              title: Text(
                'View Outstanding Loans',
                style: Theme.of(context).textTheme.body2,
              ),
            ),
          ),
          Card(
            elevation: 3,
            child: ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Guarantorship()));
              },
              title: Text(
                'View guarantorship status',
                style: Theme.of(context).textTheme.body2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RequestLoan extends StatefulWidget {
  @override
  _RequestLoanState createState() => _RequestLoanState();
}

class _RequestLoanState extends State<RequestLoan> {
  Widget requestLoan() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 22, top: 15),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Type of Loan',
              style: Theme.of(context).textTheme.display2,
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 8),
          child: TextField(
            style: TextStyle(color: Colors.black),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 15),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Amount to borrow',
              style: Theme.of(context).textTheme.display2,
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, bottom: 30, top: 8),
          child: TextField(
            style: TextStyle(color: Colors.black),

            keyboardType: TextInputType.number,
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
        ),
        getOutlineButton(
            "APPLY NOW", () {}, Theme.of(context).textTheme.subtitle),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          'Loans',
        ),
      ),
      body: requestLoan(),
    );
  }
}

class OutstandingLoans extends StatefulWidget {
  @override
  _OutstandingLoansState createState() => _OutstandingLoansState();
}

class _OutstandingLoansState extends State<OutstandingLoans> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}

class Guarantorship extends StatefulWidget {
  @override
  _GuarantorshipState createState() => _GuarantorshipState();
}

class _GuarantorshipState extends State<Guarantorship> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          'Guarantorship',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        children: <Widget>[
          Card(
            elevation: 3,
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => G()));
              },
              title: Text(
                'Loans Guaranteed By Me',
                style: Theme.of(context).textTheme.body2,
              ),
            ),
          ),
          Card(
            elevation: 3,
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => G()));
              },
              title: Text(
                'Loans Guaranteed To Me',
                style: Theme.of(context).textTheme.body2,
              ),
            ),
          ),
          Card(
            elevation: 3,
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => G()));
              },
              title: Text(
                'Request Guarantorship',
                style: Theme.of(context).textTheme.body2,
              ),
            ),
          ),
          Card(
            elevation: 3,
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => G()));
              },
              title: Text(
                'Approve Guarantorship',
                style: Theme.of(context).textTheme.body2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class G extends StatefulWidget {
  @override
  _GState createState() => _GState();
}

class _GState extends State<G> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
