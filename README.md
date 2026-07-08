# CarRental

Итоговый проект ШИФТ — сервис аренды машин. Пишу на SwiftUI, архитектура MVVM с координатором.

## Стек

- Swift
- SwiftUI
- MVVM + Coordinator
- Юнит-тесты на XCTest

## Сборка

Проект генерируется через XcodeGen, поэтому `.xcodeproj` не лежит в репозитории.

Ставим XcodeGen один раз:

    brew install xcodegen

Дальше всё через Makefile:

    make build

Проект сгенерируется и сразу откроется в Xcode — останется нажать «Run».

## Тесты

Логику покрываю юнит-тестами, запускаются из Xcode по Cmd+U.
