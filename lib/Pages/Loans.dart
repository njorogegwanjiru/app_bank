import 'package:app_bank/utils/widgets.dart';
import 'package:flutter/material.dart';

class Loans extends StatefulWidget {
  @override
  _LoansState createState() => _LoansState();
}

class _LoansState extends State<Loans> {
  @override
  Widget build(BuildContext context) {
    Widget requestLoan() {
      return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 22, top: 8),
            child: Text(
              'Amount',
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
              'Type of Loan',
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
              "APPLY NOW", () {}, Theme.of(context).textTheme.subtitle),
        ],
      );
    }
    Widget repayLoan() {
      return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Icon(
              Icons.cached,
              size: 100,
              color: Colors.grey,
            ),
          ),
          Text(
            'No Pending Loans',
            style: Theme.of(context).textTheme.display2,
          ),
        ],
      );
    }
    Widget statusLoan() {
      return Column();
    }
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Loans",
            ),
            bottom: TabBar(
              labelStyle: Theme.of(context).appBarTheme.textTheme.display2,
              indicatorColor: Theme.of(context).colorScheme.onPrimary,
              indicatorWeight: 3,
              tabs: [
                Tab(
                  icon: Icon(Icons.money_off),
                  text: 'Request',
                ),
                Tab(
                  icon: Icon(Icons.attach_money),
                  text: 'Pay',
                ),
                Tab(
                  icon: Icon(Icons.report),
                  text: 'Status',
                ),
              ],
            ),
          ),
          body:
              TabBarView(children: [requestLoan(), repayLoan(), statusLoan()]),
        ));
  }
}
