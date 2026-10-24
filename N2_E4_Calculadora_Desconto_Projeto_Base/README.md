# N2 - E4 — Calculadora de Desconto

Este é o projeto-base da atividade **N2 - E4**.

O aplicativo principal já está implementado. Sua tarefa é completar os testes automatizados, executá-los e gerar os builds Android em APK e AAB.

## Preparar o projeto

Extraia o ZIP para uma pasta local e abra essa pasta no Visual Studio Code.

No terminal, dentro da pasta do projeto, execute:

```bash
flutter create .
flutter pub get
```

O comando `flutter create .` gera as estruturas de plataforma necessárias, incluindo a pasta `android/`.

## Executar o aplicativo

Abra um emulador Android e execute:

```bash
flutter run
```

Confirme que a Calculadora de Desconto funciona corretamente.

## Completar os testes

Complete os trechos marcados com `TODO` nos arquivos:

```text
test/discount_calculator_test.dart
test/widget_test.dart
```

Não remova os casos de teste já indicados.

## Executar os testes

```bash
flutter test
```

Todos os testes devem finalizar sem falhas.

## Gerar o APK

```bash
flutter build apk --release
```

Arquivo esperado:

```text
build/app/outputs/flutter-apk/app-release.apk
```

## Gerar o AAB

```bash
flutter build appbundle
```

Arquivo esperado:

```text
build/app/outputs/bundle/release/app-release.aab
```

## Evidências

Salve na pasta `evidencias/` imagens mostrando:

- aplicativo funcionando no emulador Android;
- execução de `flutter test` com sucesso;
- APK gerado;
- AAB gerado.

## Entrega

Compacte o projeto completo ao final da atividade usando o nome:

```text
NomeSobrenome_N2_E4.zip
```

Não entregue apenas arquivos `.dart`.
