import 'dart:io';

import 'package:agent_dart/agent_dart.dart';

/// motoko/rust function of the Counter canister
/// see ./dfx/local/counter.did
abstract class CounterMethod {
  /// use staic const as method name
  static const increment = "increment";
  static const getValue = "getValue";

  /// you can copy/paste from .dfx/local/canisters/counter/counter.did.js
  static final ServiceClass idl = IDL.Service({
    CounterMethod.getValue: IDL.Func([], [IDL.Nat], ['query']),
    CounterMethod.increment: IDL.Func([], [], []),
  });
}

///
/// Counter class, with AgentFactory within
class Counter {
  /// AgentFactory is a factory method that creates Actor automatically.
  /// Save your strength, just use this template
  AgentFactory? _agentFactory;

  /// CanisterCator is the actor that make all the request to Smartcontract.
  CanisterActor? get actor => _agentFactory?.actor;
  final String canisterId;
  final String url;

  Counter({required this.canisterId, required this.url}) {
    print('canisterId: $canisterId');
    print('url: $url');
  }
  // A future method because we need debug mode works for local developement
  Future<void> setAgent(
      {String? newCanisterId,
      ServiceClass? newIdl,
      String? newUrl,
      Identity? newIdentity,
      bool? debug}) async {

    print('newCanisterId: $newCanisterId');
    print('newIdl: $newIdl');
    print('newUrl: $newUrl');
    print('newIdentity: $newIdentity');
    print('debug: $debug');
          
    // try {
    //   // Your network request code here

      _agentFactory ??= await AgentFactory.createAgent(
          canisterId: newCanisterId ?? canisterId,
          url: newUrl ?? url,
          idl: newIdl ?? CounterMethod.idl,
          identity: newIdentity,
          debug: debug ?? true);



    // } catch (e) {
    //   if (e is SocketException) {
    //     print('Cannot connect to the server. Please check your internet connection and server status.');
    //     print('Exception: $e');

    //   } else {
    //     // Re-throw the exception for further handling
    //     rethrow;
    //   }
    //}        
      }

  /// Call canister methods like this signature
  /// ```dart
  ///  CanisterActor.getFunc(String)?.call(List<dynamic>) -> Future<dynamic>
  /// ```

  Future<void> increment() async {
    try {
      await actor?.getFunc(CounterMethod.increment)?.call([]);
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getValue() async {
    try {
      print("actor: $actor");
      print("CounterMethod: ${CounterMethod}");
      print("CounterMethod.getValue: ${CounterMethod.getValue}");

      ActorMethod? func = actor?.getFunc(CounterMethod.getValue);
      print("getFunc result: $func");

      if (func != null) {
        var res = await func([]);
        print("Function call result: $res");

        if (res != null) {
          return (res as BigInt).toInt();
        } else {
          print("Function call returned null");
        }
      } else {
        print("getFunc returned null");
      }

      throw "Cannot get count";
    } catch (e) {
      print("Caught error: $e");
      rethrow;
    }
  }  
}
