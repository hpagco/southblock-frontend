

/// Top-level pages of the app.
enum Pg { home, menu, rewards, careers, about, locations }

/// Navigation callback: go to a page, optionally preselecting a menu category id.
typedef NavFn = void Function(Pg page, {String? cat});
