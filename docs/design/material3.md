# Material Design 3

Use `ThemeData(useMaterial3: true)`, `ColorScheme` semântico Light/Dark e `ThemeMode.system`. Use papéis `on...` correspondentes e `surfaceContainer*` para hierarquia de superfícies. Navegação, FAB, botões, cards e chips devem obter cores do tema, sem hexadecimais dispersos nos widgets.

Use `ThemeExtension` para cores semânticas próprias do produto (por exemplo, curtidas e tendências), com dados Light/Dark e implementação de `copyWith` e `lerp`. Isso não torna válidos pares de baixo contraste: medir e revisar todos os papéis usados é critério de aceite.
