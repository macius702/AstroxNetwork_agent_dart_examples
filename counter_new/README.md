# TODO


- [x] Host static Flutter chrome on ICP as frontend canister
- [ ] Check Android talking to playground canister

# Useful commands

```
dfx start --clean --background
dfx deploy
flutter doctor -v
flutter clean
flutter pub get
flutter devices
flutter run
flutter run -d chrome


# build and deploy in playground mainnet: !!! 
dfx deploy --playground 
dart generate_config.dart
flutter build web --profile --dart-define=Dart2jsOptimization=O0 --source-maps
dfx deploy --playground 
# (can be the second time working) and after playground expires  then: rm -rf .dfx/playground)
```
 
# counter_new

A flutter sample app that connects to local canister

## Quick Start
1. `dfx` installed to your local machine, making sure you can deploy canister to your local machine.
2. `flutter` installed, and use `flutter doctor -v` make sure everything works
3. `flutter pub get` before running this example.
4. If you want to use MacOS to debug, make sure `macos/Runner/DebugProfile.entitlements` and `macos/Runner/Release.entitlements` have content below
    ```xml
    <dict>
        ...
        <key>com.apple.security.network.client</key>
        <true/>
    </dict>
    ```
5. Deploy canister use `dfx deploy`, the `counter` canister will be running on your local replica. Make sure you put the counter canister id inside `.dfx/local/canister_ids.json` to your `main.dart`, the json like this:
    ```json
    {
        "__Candid_UI": {
            "local": "x2dwq-7aaaa-aaaaa-aaaxq-cai"
        },
        "counter": {
            "local": "x5cqe-syaaa-aaaaa-aaaxa-cai"
        }
    }
    ```
6. inside `main.dart`, you should change settings with `canisterId` to your actual id.
   ```dart
    Future<void> initCounter({Identity? identity}) async {
        
        // initialize counter, change canister id here
        counter = Counter(canisterId: 'x5cqe-syaaa-aaaaa-aaaxa-cai', url: 'http://localhost:8000');
        // set agent when other paramater comes in like new Identity
        await counter?.setAgent(newIdentity: identity);
        
    }
   ```
7. start
    ```bash
    flutter run
    ```

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
