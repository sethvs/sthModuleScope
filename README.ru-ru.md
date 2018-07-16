# sthModuleScope

**sthModuleScope** - это модуль, содержащий четыре функции, предназначенные для работы с элементами в области модуля.

В модуль входят следующие функции:

[**Enter-sthModuleScope**](#enter-sthmodulescope) - Функция Enter-sthModuleScope входит в область указанного модуля, позволяя выполнять команды в области этого модуля.
Это дает возможность вызывать внутренние функции модуля и обращаться к неэкспортированным в рабочую среду переменным.
Во время нахождения в области модуля, строка приглашения отображает имя этого модуля.
Для выхода из области модуля используйте команду 'exit'.

[**Get-sthModuleScopeFunction**](#get-sthmodulescopefunction) - Функция Get-sthModuleScopeFunction возвращает список всех функций модуля, указанного в качестве значения параметра -Module, или модуля, в область которого был совершен вход при помощи функции Enter-sthModuleScope.
По умолчанию, Get-sthModuleScopeFunction возвращает все функции - как публичные, так и частные, однако, вы можете указать нужный вам тип функций, используя параметры -PublicOnly и -PrivateOnly.

[**Get-sthModuleScopeVariable**](#get-sthmodulescopevariable) - Функция Get-sthModuleScopeVariable возвращает список всех переменных модуля, указанного в качестве значения параметра -Module,или модуля, в область которого был совершен вход при помощи функции Enter-sthModuleScope.
По умолчанию, Get-sthModuleScopeVariable возвращает все переменные - как публичные, так и частные, однако, вы можете указать нужный вам тип переменных, используя параметры -PublicOnly и -PrivateOnly.

[**Get-sthScopeDepth**](#get-sthscopedepth) - Функция Get-sthScopeDepth выводит расположение текущей области относительно глобальной.
Значение 0 говорит о том, что вы в данный момент находитесь в глобальной области, значение 1 - о том, что текущая область расположена непосредственно под глобальной, значение 2 - о том, что между текущей областью и глобальной расположена еще одна и так далее.

Вы можете установить модуль sthModuleScope из PowerShell Gallery:

```
Install-Module sthModuleScope
```

## Как с этим работать?

### Enter-sthModuleScope

Команда входит в область модуля с именем 'module_name'.

Во время нахождения в области модуля, строка приглашения отображает имя этого модуля.

Для выхода из области модуля используется команда 'exit'.

```
PS C:\> Enter-sthModuleScope -Module module_name

[module_name] PS C:\>> exit

PS C:\>
```

---

Команды входят в область модуля, используя объект PSModuleInfo.

Первая команда использует командлет Get-Module для получения объекта PSModuleInfo модуля с именем 'module_name'.

Вторая команда входит в область модуля 'module_name'.

Третья команда выходит из области модуля.

```
PS C:\> $Module = Get-Module -Name 'module_name' -ListAvailable

PS C:\> Enter-sthModuleScope -Module $Module

[module_name] PS C:\>> exit

PS C:\>
```

---

Команда входит в область модуля, получая его имя посредством конвейера.

```
PS C:\> 'module_name' | Enter-sthModuleScope

[module_name] PS C:\>>
```

---

Команда входит в область модуля, получая объект PSModuleInfo посредством конвейера.

```
PS C:\> Get-Module module_name -ListAvailable | Enter-sthModuleScope

[module_name] PS C:\>>
```

### Get-sthModuleScopeFunction

Команды получают все функции, определенные в модуле 'module_name'.

Первая команда входит в область модуля с именем 'module_name'.

Вторая команда получает все функции модуля.

```
PS C:\> Enter-sthModuleScope -Module module_name

[module_name] PS C:\>> Get-sthModuleScopeFunction
```

---

Команды получают все публичные функции, определенные в модуле 'module_name'.

Первая команда входит в область модуля с именем 'module_name'.

Вторая команда получает все публичные функции модуля.

```
PS C:\> Enter-sthModuleScope -Module module_name

[module_name] PS C:\>> Get-sthModuleScopeFunction -PublicOnly
```

---

Команды получают все частные функции, определенные в модуле 'module_name'.

Первая команда входит в область модуля с именем 'module_name'.

Вторая команда получает все частные функции модуля.

```
PS C:\> Enter-sthModuleScope -Module module_name

[module_name] PS C:\>> Get-sthModuleScopeFunction -PrivateOnly
```

---

Команда получает все функции, определенные в модуле 'module_name'.

```
PS C:\> Get-sthModuleScopeFunction -Module 'module_name'
```

---

Команда получает все функции, определенные в модуле 'module_name', используя объект PSModuleInfo в качестве значения параметра -Module.

```
PS C:\> $Module = Get-Module -Name 'module_info' -ListAvailable

PS C:\> Get-sthModuleScopeFunction -Module $Module
```

---

Команда выводит все функции, определенные в модуле, получая его имя посредством конвейера.

```
PS C:\> 'module_name' | Get-sthModuleScopeFunction
```

---

Команда выводит все функции, определенные в модуле, получая объект PSModuleInfo посредством конвейера.

```
PS C:\> Get-Module -Name 'module_name' -ListAvailable | Get-sthModuleScopeFunction
```

### Get-sthModuleScopeVariable

Команды получают все переменные, определенные в модуле 'module_name'.

Первая команда входит в область модуля с именем 'module_name'.

Вторая команда получает все переменные модуля.

```
PS C:\> Enter-sthModuleScope -Module module_name

[module_name] PS C:\>> Get-sthModuleScopeVariable
```

---

Команды получают все публичные переменные, определенные в модуле 'module_name'.

Первая команда входит в область модуля с именем 'module_name'.

Вторая команда получает все публичные переменные модуля.

```
PS C:\> Enter-sthModuleScope -Module module_name

[module_name] PS C:\>> Get-sthModuleScopeVariable -PublicOnly
```

---

Команды получают все частные переменные, определенные в модуле 'module_name'.

Первая команда входит в область модуля с именем 'module_name'.

Вторая команда получает все частные переменные модуля.

```
PS C:\> Enter-sthModuleScope -Module module_name

[module_name] PS C:\>> Get-sthModuleScopeVariable -PrivateOnly
```

---

Команда получает все переменные, определенные в модуле 'module_name'.

```
PS C:\> Get-sthModuleScopeVariable -Module 'module_name'
```

---

Команда получает все переменные, определенные в модуле 'module_name', используя объект PSModuleInfo в качестве значения параметра -Module.

```
PS C:\> $Module = Get-Module -Name 'module_info' -ListAvailable

PS C:\> Get-sthModuleScopeVariable -Module $Module
```

---

Команда выводит все переменные, определенные в модуле, получая его имя посредством конвейера.

```
PS C:\> 'module_name' | Get-sthModuleScopeVariable
```

---

Команда выводит все переменные, определенные в модуле, получая объект PSModuleInfo посредством конвейера.

```
PS C:\> Get-Module -Name 'module_name' -ListAvailable | Get-sthModuleScopeVariable
```

### Get-sthScopeDepth

Команда выводит расположение текущей области.

Результат 0 означает, что в данный момент вы находитесь в глобальной области.

```
PS C:\> Get-sthScopeDepth
0
```

---

Команда Get-sthScopeDepth получает расположение текущей области, будучи вызванной из области модуля.

Первая команда входит в область модуля с именем 'module_name'.

Вторая команда получает расположение текущей области.

Результат 1 означает, что вы находитесь на одну область ниже глобальной.

```
PS C:\> Enter-sthModuleScope -Module module_name

[module_name] PS C:\>> Get-sthScopeDepth
1
```

---

Команды получают расположение текущей области при отладке функции.

Первая команда активирует отладку сценариев.

Вторая команда вызывает функцию Get-sthModuleScopeFunction с указанием 'sthModuleScope' в качестве значения параметра -Module.

Далее, на первый запрос отладчика указывается 'Y', что ведет к продолжению выполнения функции.

На второй запрос отладичка указывается 'S', что приводит к приостановке выполнения.

Затем, в командной строке отладчика вызывается функция Get-sthScopeDepth.

Результат 2 означает, что вы находитесь на две области ниже глобальной.

```
PS C:\> Set-PSDebug -Step
PS C:\> Get-sthModuleScopeFunction -Module sthModuleScope

Continue with this operation?
   1+  >>>> Get-sthModuleScopeFunction -Module sthModuleScope
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): Y

Continue with this operation?
  26+  >>>> {
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): S

PS C:\>> Get-sthScopeDepth
2
```