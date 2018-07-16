# sthModuleScope

**sthModuleScope** - is a module containing four functions for working with elements in module's scope.

It contains following functions:

[**Enter-sthModuleScope**](#enter-sthmodulescope) - Function enters the scope of a specified module and allows to invoke command in that scope.
This provides means to call internal module functions and access nonexported module variables.
When you enter a module scope, command prompt changes to include the name of the module.
To exit from the module scope type 'exit'.

[**Get-sthModuleScopeFunction**](#get-sthmodulescopefunction) - Function returns all the functions, defined in the module specified by -Module parameter,
or the module, the scope of which was entered by using the Enter-sthModuleScope function.
By default, Get-sthModuleScopeFunction gets all functions - public and private, but you can specify which functions you are interested in by using -PublicOnly and -PrivateOnly parameters.

[**Get-sthModuleScopeVariable**](#get-sthmodulescopevariable) - Function returns all the variables, defined in the module specified by -Module parameter,
or the module, the scope of which was entered by using the Enter-sthModuleScope function.
By default, Get-sthModuleScopeVariable gets all variables - public and private, but you can specify which variables you are interested in by using -PublicOnly and -PrivateOnly parameters.

[**Get-sthScopeDepth**](#get-sthscopedepth) - Function returns current scope depth, where 0 means, that you are in the global scope, 1 - you are one scope deeper than global, 2 - you are two scopes deeper than global, etc.

You can install sthModuleScope module from PowerShell Gallery:

```
Install-Module sthModuleScope
```

## How to use it?

### Enter-sthModuleScope

This command enters the scope of the module.

When enter, the command prompt changes to include the name of the module.

After that, the 'exit' command issued to exit the module's scope.

```
PS C:\> Enter-sthModuleScope -Module module_name

[module_name] PS C:\>> exit

PS C:\>
```

---

These commands enter the scope of the module using PSModuleInfo object.

The first command uses the Get-Module cmdlet to get PSModuleInfo object for the module 'module_name'.

The second command enters the scope of the module 'module_name'.

The third command exits the module's scope.

```
PS C:\> $Module = Get-Module -Name 'module_name' -ListAvailable

PS C:\> Enter-sthModuleScope -Module $Module

[module_name] PS C:\>> exit

PS C:\>
```

---

This command enters the scope of the module using pipeline.

```
PS C:\> 'module_name' | Enter-sthModuleScope

[module_name] PS C:\>>
```

---

This command enters the scope of the module by sending PSModuleInfo object through the pipeline.

```
PS C:\> Get-Module module_name -ListAvailable | Enter-sthModuleScope

[module_name] PS C:\>>
```

### Get-sthModuleScopeFunction

These commands get all functions, defined in the module 'module_name'.

The first command enters the scope of the module 'module_name'.

The second command gets all the module's functions.

```
PS C:\> Enter-sthModuleScope -Module module_name

[module_name] PS C:\>> Get-sthModuleScopeFunction
```

---

These commands get all public functions, defined in the module 'module_name'.

The first command enters the scope of the module 'module_name'.

The second command gets all the module's public functions.

```
PS C:\> Enter-sthModuleScope -Module module_name

[module_name] PS C:\>> Get-sthModuleScopeFunction -PublicOnly
```

---

These commands get all private functions, defined in the module 'module_name'.

The first command enters the scope of the module 'module_name'.

The second command gets all the module's private functions.

```
PS C:\> Enter-sthModuleScope -Module module_name

[module_name] PS C:\>> Get-sthModuleScopeFunction -PrivateOnly
```

---

This command gets all functions, defined in the module 'module_name'.

```
PS C:\> Get-sthModuleScopeFunction -Module 'module_name'
```

---

These commands get all functions, defined in the module 'module_name' by using PSModuleInfo object.

```
PS C:\> $Module = Get-Module -Name 'module_info' -ListAvailable

PS C:\> Get-sthModuleScopeFunction -Module $Module
```

---

This command gets all functions, defined in the module 'module_name' by using pipeline.

```
PS C:\> 'module_name' | Get-sthModuleScopeFunction
```

---

This command gets all functions, defined in the module 'module_name' by accepting PSModuleInfo object from the pipeline.

```
PS C:\> Get-Module -Name 'module_name' -ListAvailable | Get-sthModuleScopeFunction
```

### Get-sthModuleScopeVariable

These commands get all variables, defined in the module 'module_name'.

The first command enters the scope of the module 'module_name'.

The second command gets all the module's variables.

```
PS C:\> Enter-sthModuleScope -Module module_name

[module_name] PS C:\>> Get-sthModuleScopeVariable
```

---

These commands get all public variables, defined in the module 'module_name'.

The first command enters the scope of the module 'module_name'.

The second command gets all the module's public variables.

```
PS C:\> Enter-sthModuleScope -Module module_name

[module_name] PS C:\>> Get-sthModuleScopeVariable -PublicOnly
```

---

These commands get all private variables, defined in the module 'module_name'.

The first command enters the scope of the module 'module_name'.

The second command gets all the module's private variables.

```
PS C:\> Enter-sthModuleScope -Module module_name

[module_name] PS C:\>> Get-sthModuleScopeVariable -PrivateOnly
```

---

This command gets all variables, defined in the module 'module_name'.

```
PS C:\> Get-sthModuleScopeVariable -Module 'module_name'
```

---

These commands get all variables, defined in the module 'module_name' by using PSModuleInfo object.

```
PS C:\> $Module = Get-Module -Name 'module_info' -ListAvailable

PS C:\> Get-sthModuleScopeVariable -Module $Module
```

---

This command gets all variables, defined in the module 'module_name' by using pipeline.

```
PS C:\> 'module_name' | Get-sthModuleScopeVariable
```

---

This command gets all variables, defined in the module 'module_name' by accepting PSModuleInfo object from the pipeline.

```
PS C:\> Get-Module -Name 'module_name' -ListAvailable | Get-sthModuleScopeVariable
```

### Get-sthScopeDepth

This command gets current scope depth.

The result is 0, which means - you are in the global scope.

```
PS C:\> Get-sthScopeDepth
0
```

---

These commands get current scope depth from the module's scope.

The first command enters the scope of the module 'module_name'.

The second command gets current scope depth.

The result is 1, which means - you are one scope deeper than the global scope.

```
PS C:\> Enter-sthModuleScope -Module module_name

[module_name] PS C:\>> Get-sthScopeDepth
1
```

---

These commands get current module scope depth while debugging the Get-sthModuleScopeFunction function.

The first command enables script debugging.

The second command invokes the Get-sthModuleScopeFunction function with 'sthModuleScope' as the -Module parameter value.

Then, on the first debug request 'Y' is specified, which means continuing function execution.

On the second debug request 'S' is specified, which means suspending execution.

Then, at the debug prompt the Get-sthScopeDepth function invoked.

The result is 2, which means - you are two scopes deeper, than the global scope.

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
