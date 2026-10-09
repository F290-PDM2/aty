# ATY — diretrizes para o Codex

## Contexto do projeto

ATY — Comunidade Fatec é um aplicativo Flutter. Consulte `docs/design/` e `specs/001-design-system/` antes de mudar marca, cores ou tipografia. As referências visuais originais ainda não foram transferidas; não trate imagens raster como SVGs finais.

## Arquitetura

Adote uma arquitetura limpa, organizada por funcionalidade e adaptada da [introdução à arquitetura Flutter com Riverpod de Andrea Bizzotto](https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/). A referência descreve quatro camadas: data, domain, application (opcional) e presentation. Esta é uma adaptação para o ATY, não uma arquitetura oficial do Riverpod.

### Estrutura sugerida

```text
lib/
  app/                         # composição do app, tema e roteamento
  core/                        # tipos/utilitários transversais sem regra de feature
  features/<feature>/
    data/
      data_sources/            # REST, Supabase e outros adapters externos
      dtos/                    # formatos de transporte e serialização
      repositories/             # implementações das portas do domínio
    domain/
      models/                  # entidades imutáveis e regras locais
      repositories/            # contratos/portas independentes de infraestrutura
    application/               # serviços de casos de uso que orquestram múltiplos repos
    presentation/
      controllers/             # estado e comandos Riverpod
      widgets/                 # widgets específicos da funcionalidade
      screens/
```

Use apenas as camadas necessárias: `application/` é opcional para lógica que coordena múltiplos repositórios ou é compartilhada. Não crie classes/camadas sem responsabilidade concreta.

### Responsabilidades e dependências

- **Presentation:** widgets exibem estado e enviam intenções aos controllers. Controllers Riverpod, preferencialmente `AsyncNotifier` quando há mutações assíncronas, coordenam a tela e expõem estado previsível (`AsyncValue` para operações assíncronas). Não façam chamadas HTTP/Supabase diretamente.
- **Domain:** modelos de negócio imutáveis e contratos de repositório. Não importa Flutter, Dio, Supabase, JSON ou detalhes de UI/infraestrutura.
- **Data:** data sources conversam com APIs; DTOs tratam formatos externos/serialização; repositórios implementam os contratos do domínio e convertem DTOs em modelos de domínio.
- **Application (opcional):** serviços/casos de uso orquestram mais de uma fonte/repositório e ficam entre controllers e repositórios. Evite duplicar lógica simples de um único repositório.
- **Fluxo:** dados sobem data → domain → application/controller → presentation. Comandos descem presentation → controller → application/domain contract → implementação data. Infraestrutura depende dos contratos de domínio; domínio não depende da infraestrutura.
- Use Riverpod como mecanismo reativo de composição/injeção e cache. Mantenha providers próximos à feature/composição que os utiliza; evite um arquivo global monolítico.

### Modelos e geração de código

- Use Freezed para entidades/uniões imutáveis quando trouxer valor. Mantenha entidades de domínio sem serialização específica de API; use DTOs Freezed/JSON na camada `data` quando o formato externo exigir.
- Use `json_annotation` nos arquivos de transporte e `json_serializable` como gerador.
- Use `riverpod_annotation` no código-fonte e `riverpod_generator` apenas como ferramenta de desenvolvimento. Inclua os `part` gerados e não edite arquivos `.g.dart`/`.freezed.dart` manualmente.
- Rode `dart run build_runner build --delete-conflicting-outputs` após alterações que dependam de geração.

### Integrações

- `Dio` fica em data sources para APIs HTTP externas, com instância configurada/injetada por providers e interceptors definidos centralmente.
- Use `supabase_flutter` para bootstrap e cliente Flutter. Restrinja acesso Supabase a data sources/repositórios. Nunca inclua `service_role`/secret key no cliente; chaves públicas não substituem RLS.
- `go_router` configura rotas em `app/` e encaminha para telas de apresentação; não deve carregar regras de negócio.
- `timeago` fica na apresentação/formatação, sem contaminar entidades do domínio.
- `google_fonts` fornece a tipografia prescrita em `docs/design/typography.md`.

## Dependências

- Mantenha bibliotecas usadas pelo app em `dependencies`.
- Mantenha geradores e ferramentas somente de build em `dev_dependencies`: `build_runner`, `riverpod_generator`, `freezed` e `json_serializable`.
- Para Riverpod em Flutter use `flutter_riverpod` e `riverpod_annotation`; não adicione `riverpod` separado sem necessidade concreta, pois `flutter_riverpod` já traz a integração Flutter e depende do core.
- Use `supabase_flutter` (SDK cliente Flutter), não o pacote `supabase` puro como substituto do bootstrap Flutter.
- Preserve `pubspec.lock` do aplicativo no controle de versão e faça atualizações de dependências conscientemente.

## Regras gerais

- Repositório GitHub pretendido: `P290-PDM2/aty`. Não crie outro nome/organização nem publique credenciais.
- Mantenha `docs/design/` e `specs/001-design-system/` sincronizados com as decisões aprovadas.
- Não declare contraste, acessibilidade ou validação técnica sem medições/evidência.
