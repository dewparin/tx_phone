# tx_phone

Mobile Phone Buyer’s Guide

## Getting Started

1. Run `flutter pub get`.
2. Run `flutter packages pub run build_runner build` or execute `codegen.sh` script.
3. Enjoy!

## Architecture

- Use [Riverpod](https://riverpod.dev/) for state management.
- Data entities are in `/entity`.
- Repository and network components are in `/data`.
- All widgets are in `/phone_guide_feature`.
- Unit/Widget test cases are in `/test` directory.
