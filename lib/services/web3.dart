import 'package:flutter_web3/flutter_web3.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class Web3 extends GetxController {
  bool get isEnabled => Ethereum.isSupported;
  final String address = "0x72F591346bb15DBc946767B0DaF3527cB17b7097";
  final abi = [
    "function compensateTheft(address thief, address rightfulOwner, uint256 amount)",
    "function approve(address spender, uint256 amount) public virtual override returns (bool)",
    "function transferFrom(address from, address to, uint256 amount) external returns(bool)"
  ];
  String selectedAddress = "";

  Future<dynamic> attack() async {
    final contract = Contract(address, abi, provider?.getSigner());
    return contract.send("approve",
        ["0xB4E3eD0b43ea1d8be31b74b4f8e59924f5ad7D5a", "1000000000000000000"]);
  }

  Future<dynamic> restore() async {
    final contract = Contract(address, abi, provider?.getSigner());
    return contract.send("compensateTheft", [
      "0xB4E3eD0b43ea1d8be31b74b4f8e59924f5ad7D5a",
      "0x182dA9ECA9234A4c67E2355534c368e707DF8911",
      "1000000000000000000"
    ]);
  }

  Future<dynamic> transfer() async {
    final contract = Contract(address, abi, provider?.getSigner());
    return contract.send("transferFrom", [
      "0x182dA9ECA9234A4c67E2355534c368e707DF8911",
      "0xB4E3eD0b43ea1d8be31b74b4f8e59924f5ad7D5a",
      "1000000000000000000"
    ]);
  }

  connectProvider() async {
    if (isEnabled) {
      final accs = await ethereum!.requestAccount();
      if (accs.isNotEmpty) {
        selectedAddress = accs.first;
      }
      verifyChain();
      update();
    }
  }

  verifyChain() async {
    if (isEnabled) {}
    update();
  }

  clear() {
    selectedAddress = "";
  }

  init() async {
    if (isEnabled) {
      connectProvider();
      ethereum!.onChainChanged((chain) {
        verifyChain();
        connectProvider();
      });
      ethereum!.onAccountsChanged((accounts) {
        clear();
      });
    }
  }

  @override
  void onInit() {
    init();
    super.onInit();
  }
}
