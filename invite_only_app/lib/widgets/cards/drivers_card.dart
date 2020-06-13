import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

class DriversCard extends StatelessWidget {
  final DriversLicense drivers;

  const DriversCard(this.drivers, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          top: 8.0,
          right: 16.0,
          bottom: 8.0,
        ),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Column(
                children: <Widget>[
                  Icon(
                    Icons.person_pin,
                    size: 48.0,
                    color: Theme.of(context).primaryColorLight,
                  ),
                  Container(height: 8.0),
                  Text('Drivers License'),
                ],
              ),
              subtitle: Text(
                'Identification Information',
                textAlign: TextAlign.center,
              ),
            ),
            Divider(),
            Row(
              children: <Widget>[
                _buildDetail(
                  context,
                  '${drivers.firstNames} ${drivers.surname}',
                  'Full Name',
                ),
                _buildDetail(
                  context,
                  _gender,
                  'Gender',
                ),
              ],
            ),
            Container(height: 16.0),
            Row(
              children: <Widget>[
                _buildDetail(
                  context,
                  drivers.idNumber,
                  'ID Number',
                ),
                _buildDetail(
                  context,
                  formatDate(drivers.birthDate, [d, ' ', MM, ' ', yyyy]),
                  'Birth Date',
                ),
              ],
            ),
            Container(height: 16.0),
            Row(
              children: <Widget>[
                _buildDetail(
                  context,
                  _driverRestrictions,
                  'Driver\'s restrictions',
                ),
                _buildDetail(
                  context,
                  drivers.vehicleCodes.reduce((c1, c2) => '$c1, $c2'),
                  'Vehicle codes',
                ),
              ],
            ),
            Container(height: 16.0),
            Row(
              children: <Widget>[
                _buildDetail(
                  context,
                  formatDate(drivers.validFrom, [d, ' ', MM, ' ', yyyy]),
                  'Valid from',
                ),
                _buildDetail(
                  context,
                  formatDate(drivers.validTo, [d, ' ', MM, ' ', yyyy]),
                  'Valid to',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetail(BuildContext context, String content, String caption) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(content),
          Text(caption, style: Theme.of(context).textTheme.caption),
        ],
      ),
    );
  }

  String get _driverRestrictions {
    if (drivers.driverRestrictions == '00') {
      return 'None';
    }

    if (drivers.driverRestrictions == '10') {
      return 'Glasses';
    }

    if (drivers.driverRestrictions == '20') {
      return 'Artificial Limb';
    }

    if (drivers.driverRestrictions == '12') {
      return 'Glasses and Artificial Limb';
    }

    return 'None';
  }

  String get _gender {
    if (drivers.gender == 'M') return 'Male';
    if (drivers.gender == 'F') return 'Female';
    return 'Not specified';
  }
}
