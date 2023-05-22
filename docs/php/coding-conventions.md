# Coding conventions

### Table of contents
- [1. General conventions](#1-general-conventions)
    * [1.1 Typehints and Return types](#11-typehints-and-return-types)
    * [1.2 Docblocks](#12-docblocks)
    * [1.3 If statements](#13-if-statements)
        + [1.3.1 Happy Path](#131-happy-path)
        + [1.3.2 Avoid else](#132-avoid-else)
- [2. Laravel conventions](#2-laravel-conventions)
    * [2.1 Case usage and naming](#21-case-usage-and-naming)
        + [2.1.1 Class names](#211-class-names)
        + [2.1.2 Artisan commands](#212-artisan-commands)
        + [2.1.3 Config files](#213-config-files)
        + [2.1.4 Routes](#214-routes)
        + [2.1.5 Views](#215-views)
        + [2.1.6 Controllers](#216-controllers)
        + [2.1.7 FormRequests and Forms](#217-formrequests-and-forms)
        + [2.1.8 Resources](#218-resources)
    * [2.2 Validation](#22-validation)
    * [2.3 Livewire](#23-livewire)
        + [2.3.1 `render()`](#231-render)
        + [2.3.2 `mount()`](#232-mount)

## 1. General conventions
### 1.1 Typehints and Return types
Class properties and function / method arguments SHOULD always have type specified.
When property can be of multiple types use Union types feature to list them all.

:white_check_mark: ***Good***
```php
class Foo
{
    public Closure|string|int|null $bar;
    
    public function foo(int $a, string $b): void
    {
        //
    }
    
    public function baz(Builder $query): Builder|Relation
    {
        //
    }
}

```
:x: ***Bad***
```php
class Foo
{
    // Missing property type.
    public $bar;
    
    // Missing `void` return type.
    public function foo(int $a, string $b)
    {
        //
    }
    
    // Mixed used where a list of types is known and MUST be defined.
    public function baz(Builder $query): mixed
    {
        //
    }
}
```

Closures and short closures SHOULD have type hints and return type declarations.

:white_check_mark: ***Good***
```php
$users->map(fn(User $user): string => $user->name);
```

:warning: ***Acceptable***
```php
$users->map(fn(User $user) => $user->name);
```

:x: ***Bad***
```php
$users->map(fn($user) => $user->name);
```

### 1.2 Docblocks
Docblocks for methods that can be fully type hinted SHOULD be omitted unless you need a description.
Only add a description when it provides more context than the method signature itself.
Use full sentences for descriptions, including a period at the end.

:white_check_mark: ***Good***
```php
class Person
{ 
    public function getName(): string
    {
        // 
    }
    
    public function setName(string $name): self
    {
        // 
    }
}

```
:x: ***Bad***
```php
class Person
{ 
    /**
    * Get person name
    *
    * @return string
    */
    public function getName(): string
    {
        // 
    }
    
    /**
    * Set person name
    *
    * @param string $name
    * @return self
    */
    public function setName(string $name): self
    {
        // 
    }
}
```

When your function / method gets passed an iterable, you SHOULD add a docblock to specify the type of key and value.
This will greatly help static analysis tools understand the code, and IDEs to provide autocompletion.

:white_check_mark: ***Good***
```php
/**
* @param array<int, User> $users 
*/
function someFunction(array $users): void 
{

}
```

:white_check_mark: ***Good***
```php
/**
* @param User[] $users 
*/
function someFunction(array $users): void 
{

}
```

:x: ***Bad***
```php
function someFunction(array $users): void 
{

}
```

If your array or collection has a few fixed keys, you MAY typehint them too using {} notation.

:white_check_mark: ***Good***
```php
/**
* @return array{email: string, name: string, age: int}
*/
function getUserData(array $users): void 
{

}
```

### 1.3 If statements
#### 1.3.1 Happy Path
Generally a function SHOULD have its unhappy path first and its happy path last.
In most cases this will cause the happy path being in an unindented part of the function which makes it more readable.

:white_check_mark: ***Good***
```php
if (! $goodCondition) {
  throw new Exception;
}
```

:x: ***Bad***
```php
if ($goodCondition) {
 // do work
}

throw new Exception;
```

#### 1.3.2 Avoid else
In general, `else` SHOULD be avoided because it makes code less readable.
In most cases it can be refactored using early returns.
This will also cause the happy path to go last, which is desirable.

:white_check_mark: ***Good***
```php
if (! $conditionA) {
   // condition A failed

   return;
}

if (! $conditionB) {
   // condition A passed, B failed

   return;
}

// condition A and B passed
```

:x: ***Bad***
```php
if ($conditionA) {
   if ($conditionB) {
      // condition A and B passed
   }
   else {
     // condition A passed, B failed
   }
}
else {
   // condition A failed
}
```

## 2. Laravel conventions
## 2.1 Case usage and naming
### 2.1.1 Class names
All classes MUST be named using `PascalCase`.

:white_check_mark: ***Good***
```shell
class UserManager
```

Classes with abbreviations also MUST follow `PascalCase` naming.

:white_check_mark: ***Good***
```shell
class GdprManager
```

:x: ***Bad***
```shell
class GDPRManager
```

### 2.1.2 Artisan commands
The names given to artisan commands MUST all use `kebab-case`.

:white_check_mark: ***Good***
```shell
php artisan prune-stale-records
```

:x: ***Bad***
```shell
php artisan prune_stale_records
```

:x: ***Bad***
```shell
php artisan pruneStaleRecords
```

Use namespaces and `:` notation for grouping.

:white_check_mark: ***Good***
```shell
php artisan audit:show-latest-records
php artisan audit:prune-stale-records
```

:x: ***Bad***
```shell
php artisan show-latest-audit-records
php artisan prune-stale-audit-records
```

### 2.1.3 Config files
Configuration files MUST use `kebab-case`.

:white_check_mark: ***Good***
```php
config/
  pdf-generator.php
```

:x: ***Bad***
```php
config/
  pdf_generator.php
```
:x: ***Bad***
```php
config/
  pdfGenerator.php
```

Configuration keys MUST use `snake_case`.

:white_check_mark: ***Good***
```php
<?php

declare(strict_types=1);

return [
    'chrome_path' => env('CHROME_PATH'),
];
```

:x: ***Bad***
```php
<?php

declare(strict_types=1);

return [
    'chromePath' => env('CHROME_PATH'),
];
```

### 2.1.4 Routes
You SHOULD use the route tuple notation when possible.

:white_check_mark: ***Good***
```php
Route::get('/users', [UsersController::class, 'index']);
```

:x: ***Bad***
```php
Route::get('/users', 'UsersController@index');
```

Route names SHOULD use plural resource name as prefix followed by action with `.` as a glue.
Route names should use `snake_case`.

:white_check_mark: ***Good***
```php
Route::get('/users', [UsersController::class, 'index'])->name('users.index');
```

:white_check_mark: ***Good***
```php
Route::post('/file-upload', FileUploadController::class)->name('file_upload');
```

:white_check_mark: ***Good***
```php
Route::post('/file-upload', [FileUploadController::class, 'index'])->name('file_upload.index');
```

:x: ***Bad***
```php
Route::get('/users', 'UserController@index')->name('users.list');
```

:x: ***Bad***
```php
Route::post('/file-upload', [FileUploadController::class, 'index'])->name('file.upload');
```

Route parameters SHOULD use `camelCase`.

:white_check_mark: ***Good***
```php
Route::get('/basket-items/{basketItem}', [BasketItemsController::class, 'show'])->name('basket_items.show');
```

:x: ***Bad***
```php
Route::get('/basket-items/{basket_item}', [BasketItemsController::class, 'show'])->name('basket_items.show');
```

Route file names should use `kebab-case`.

:white_check_mark: ***Good***
```php
routes/
  articles.php
  article-comments.php
```

:x: ***Bad***
```php
routes/
  articles.php
  article_comments.php
```

### 2.1.5 Views
Views SHOULD use `kebab-case` or `snake_case`. Mixing case is forbidden.

:white_check_mark: ***Good***
```shell
article-comment.blade.php
file-upload.blade.php
```

:warning: ***Acceptable***
```shell
article_comment.blade.php
file_upload.blade.php
```

:x: ***Bad***
```shell
article_comment.blade.php
file-upload.blade.php
```

### 2.1.6 Controllers
Controllers that control a resource MUST use the plural resource name.

:white_check_mark: ***Good***
```php
class PostsController extends Controller
{
    // ...
}
```

:x: ***Bad***
```php
class PostController extends Controller
{
    // ...
}
```

When writing non-resourceful controller you MUST use {Action}Controller naming with correct words position.

:white_check_mark: ***Good***
```php
class FileUploadController extends Controller
{
    // ...
}
```

:x: ***Bad***
```php
class UploadFileController extends Controller
{
    // ...
}
```

Controllers SHOULD use CRUD methods.

| Verb       | URI               | Action  | Route Name      |
|------------|-------------------|---------|-----------------|
| GET        | `/photos`           | index   | photos.index    |
| GET        | `/photos/create`    | create  | photos.create   |
| POST       | `/photos/store`     | store   | photos.store    |
| GET        | `/photos/{photo}`   | show    | photos.show     |
| GET        | `/photos/{photo}/edit` | edit | photos.edit     |
| PUT/PATCH  | `/photos/{photo}`   | update  | photos.update   |
| DELETE     | `/photos/{photo}`   | destroy | photos.destroy  |

:white_check_mark: ***Good***
```php
class FileUploadController extends Controller
{
    public function store(FileUploadRequest $request): Response
    {
        // 
    }
}
```

:x: ***Bad***
```php
class FileUploadController extends Controller
{
    public function upload(FileUploadRequest $request): Response
    {
        // 
    }
}
```

### 2.1.7 FormRequests and Forms
FormRequests and Forms MUST use the singular resource name.

:white_check_mark: ***Good***
```php
class UserRequest extends FormRequest
{
    // ...
}
```
:white_check_mark: ***Good***
```php
class UserForm extends Form
{
    // ...
}
```

:x: ***Bad***
```php
class UsersRequest extends FormRequest
{
    // ...
}
```
:x: ***Bad***
```php
class UsersForm extends Form
{
    // ...
}
```

### 2.1.8 Resources
Eloquent Resources MUST use the singular resource name.

:white_check_mark: ***Good***
```php
class UserResource extends Resource
{
    // ...
}
```
:white_check_mark: ***Good***
```php
class UserCollectionResource extends CollectionResource
{
    // ...
}
```

:x: ***Bad***
```php
class UsersResource extends Resource
{
    // ...
}
```
:x: ***Bad***
```php
class UsersCollectionResource extends Resource
{
    // ...
}
```

### 2.2 Validation
When using multiple rules for one field in a form request, avoid using `|`, you SHOULD always use array notation.
Using an array notation will make it easier to apply custom rule classes to a field and resolve conflicts.

:white_check_mark: ***Good***
```php
public function rules(): array
{
    return [
        'email' => ['required', 'email'],
    ];
}
```

:warning: ***Acceptable***
```php
public function rules(): array
{
    return [
        'name' => 'required',
    ];
}
```

:x: ***Bad***
```php
public function rules(): array
{
    return [
        'email' => 'required|email',
    ];
}
```

### 2.3 Livewire
#### 2.3.1 `render()`
Livewire component's `render` method MUST be a last method in a class.

:white_check_mark: ***Good***
```php
class EmailInput extends Component
{
    public string $email = '';

    public function rules(): array
    {
        return [
            'email' => ['required', 'email'],
        ];
    }
    
    public function render(): View
    {
        return view('livewire.components.inputs.email');
    }
}
```

:x: ***Bad***
```php
class EmailInput extends Component
{
    public string $email = '';
    
    public function render(): View
    {
        return view('livewire.components.inputs.email');
    }

    public function rules(): array
    {
        return [
            'email' => ['required', 'email'],
        ];
    }
}
```

#### 2.3.2 `mount()`
Livewire component's `mount` method MUST be a first method in a class.

:white_check_mark: ***Good***
```php
class EmailInput extends Component
{
    public string $email = '';
    
    public function mount(User $user): void
    {
        $this->email = $user->email ?? '';
    }

    public function rules(): array
    {
        return [
            'email' => ['required', 'email'],
        ];
    }
    
    public function render(): View
    {
        return view('livewire.components.inputs.email');
    }
}
```

:x: ***Bad***
```php
class EmailInput extends Component
{
    public string $email = '';

    public function rules(): array
    {
        return [
            'email' => ['required', 'email'],
        ];
    }
    
    public function mount(User $user): void
    {
        $this->email = $user->email ?? '';
    }
    
    public function render(): View
    {
        return view('livewire.components.inputs.email');
    }
}
```
