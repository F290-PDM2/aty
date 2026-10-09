# ATY — Comunidade Fatec

Aplicativo Flutter em preparação para a comunidade acadêmica Fatec.

## Arquitetura

O projeto segue arquitetura limpa organizada por funcionalidade, adaptada da [referência de arquitetura Flutter com Riverpod de Andrea Bizzotto](https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/). Consulte [AGENTS.md](AGENTS.md) para responsabilidades, fluxo de dependências e convenções.

Estrutura de cada funcionalidade: `data/` (data sources, DTOs e implementações de repositório), `domain/` (modelos e contratos), `application/` (orquestração opcional) e `presentation/` (controllers Riverpod, telas e widgets).

## Dependências

Bibliotecas de execução incluem `flutter_riverpod`, `riverpod_annotation`, `freezed_annotation`, `json_annotation`, `dio`, `supabase_flutter`, `timeago`, `go_router` e `google_fonts`. Geradores de código ficam em `dev_dependencies`: `build_runner`, `riverpod_generator`, `freezed` e `json_serializable`.

## Desenvolvimento

```sh
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

## Design e especificação

- `docs/design/` registra marca, cores, tipografia e Material 3.
- `specs/001-design-system/` registra a especificação inicial e seus critérios de aceite.
- As imagens de logo/tema aprovadas devem ser adicionadas a `assets/branding/` quando estiverem disponíveis. São referências raster; não são vetores finais.
