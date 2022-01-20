import 'package:distributor/core/models/crate.dart';
import 'package:stacked/stacked.dart';

enum CrateDescriptor { Green, Orange }

class CrateManagementService with ReactiveServiceMixin {
  bool _hasConfirmedStock = false;
  bool get hasConfirmedStock => _hasConfirmedStock;

  List<Crate> _crates = <Crate>[
    Crate(name: 'Yellow', count: 10),
    Crate(name: 'Red', count: 20),
  ];

  get crates => _crates;
}
