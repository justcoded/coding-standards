# Coding conventions

### Table of contents
- [1. General conventions](#1-general-conventions)
    * [1.1 Typehints and Return types](#11-typehints-and-return-types)
    * [1.2 Docblocks](#12-docblocks)
    * [1.3 If statements](#13-if-statements)
        + [1.3.1 Happy Path](#131-happy-path)
        + [1.3.2 Avoid else](#132-avoid-else)
    * [1.4 Arrays](#14-arrays)
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

✅ ***Good***
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
❌ ***Bad***
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

✅ ***Good***
```php
$users->map(fn(User $user): string => $this->name($user));
```

⚠️ ***Acceptable***
```php
$users->map(fn(User $user) => $this->name($user));
```

❌ ***Bad***
```php
$users->map(fn($user) => $this->name($user));
```

Closures and short closures SHOULD have `static` modifier if `$this` is not used.

✅ ***Good***
```php
$users->map(static fn(User $user): string => $user->name);
```

⚠️ ***Acceptable***
```php
$users->map(fn(User $user): string => $user->name);
```

### 1.2 Docblocks
Docblocks for methods that can be fully type hinted SHOULD be omitted unless you need a description.
Only add a description when it provides more context than the method signature itself.
Use full sentences for descriptions, including a period at the end.

✅ ***Good***
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
❌ ***Bad***
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

✅ ***Good***
```php
/**
* @param array<int, User> $users 
*/
function someFunction(array $users): void 
{

}
```

✅ ***Good***
```php
/**
* @param User[] $users 
*/
function someFunction(array $users): void 
{

}
```

❌ ***Bad***
```php
function someFunction(array $users): void 
{

}
```

If your array or collection has a few fixed keys, you MAY typehint them too using `{}` notation.

✅ ***Good***
```php
/**
* @param array{email: string, name: string, age: int} $users
*/
function getUserData(array $users): void 
{

}
```

### 1.3 If statements
#### 1.3.1 Happy Path
Generally a function SHOULD have its unhappy path first and its happy path last.
In most cases this will cause the happy path being in an unindented part of the function which makes it more readable.

✅ ***Good***
```php
if (! $goodCondition) {
  throw new Exception;
}
```

❌ ***Bad***
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

✅ ***Good***
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

❌ ***Bad***
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

### 1.4 Arrays
When possible you SHOULD use `...` syntax to merge arrays.

✅ ***Good***
```php
$array = [...$arr1, ...$arr2];
```

✅ ***Good***
```php
$array = [
  'user' => 'root',
  'password' => 'secret',
  'port' => 22,
  ...$options,
];
```

⚠️ ***Acceptable***
```php
$array = array_merge($arr1, $arr2);
```

⚠️ ***Acceptable***
```php
$array = array_merge([
  'user' => 'root',
  'password' => 'secret',
  'port' => 22,
], $options);
```

## 2. Laravel conventions
## 2.1 Case usage and naming
### 2.1.1 Class names
All classes MUST be named using `PascalCase`.

✅ ***Good***
```php
class UserManager
```
Classes with abbreviations also MUST follow `PascalCase` naming.

✅ ***Good***
```php
class GdprManager
```

❌ ***Bad***
```php
class GDPRManager
```

### 2.1.2 Artisan commands
The names given to artisan commands MUST all use `kebab-case`.

✅ ***Good***
```shell
php artisan prune-stale-records
```

❌ ***Bad***
```shell
php artisan prune_stale_records
```

❌ ***Bad***
```shell
php artisan pruneStaleRecords
```

Use namespaces and `:` notation for grouping.

✅ ***Good***
```shell
php artisan audit:show-latest-records
php artisan audit:prune-stale-records
```

❌ ***Bad***
```shell
php artisan show-latest-audit-records
php artisan prune-stale-audit-records
```

### 2.1.3 Config files
Configuration files MUST use `kebab-case`.

✅ ***Good***
```php
config/
  pdf-generator.php
```

❌ ***Bad***
```php
config/
  pdf_generator.php
```
❌ ***Bad***
```php
config/
  pdfGenerator.php
```

Configuration keys MUST use `snake_case`.

✅ ***Good***
```php
<?php

declare(strict_types=1);

return [
    'chrome_path' => env('CHROME_PATH'),
];
```

❌ ***Bad***
```php
<?php

declare(strict_types=1);

return [
    'chromePath' => env('CHROME_PATH'),
];
```

### 2.1.4 Routes
You SHOULD use the route tuple notation when possible.

✅ ***Good***
```php
Route::get('/users', [UsersController::class, 'index']);
```

❌ ***Bad***
```php
Route::get('/users', 'UsersController@index');
```

Route names SHOULD use plural resource name as prefix followed by action with `.` as a glue.
Route names should use `snake_case`.

✅ ***Good***
```php
Route::get('/users', [UsersController::class, 'index'])->name('users.index');
```

✅ ***Good***
```php
Route::post('/file-upload', FileUploadController::class)->name('file_upload');
```

✅ ***Good***
```php
Route::post('/file-upload', [FileUploadController::class, 'index'])->name('file_upload.index');
```

❌ ***Bad***
```php
Route::get('/users', 'UserController@index')->name('users.list');
```

❌ ***Bad***
```php
Route::post('/file-upload', [FileUploadController::class, 'index'])->name('file.upload');
```

Route parameters SHOULD use `camelCase`.

✅ ***Good***
```php
Route::get('/basket-items/{basketItem}', [BasketItemsController::class, 'show'])->name('basket_items.show');
```

❌ ***Bad***
```php
Route::get('/basket-items/{basket_item}', [BasketItemsController::class, 'show'])->name('basket_items.show');
```

Route file names should use `kebab-case`.

✅ ***Good***
```php
routes/
  articles.php
  article-comments.php
```

❌ ***Bad***
```php
routes/
  articles.php
  article_comments.php
```

### 2.1.5 Views
Views SHOULD use `kebab-case` or `snake_case`. Mixing case is forbidden.

✅ ***Good***
```shell
article-comment.blade.php
file-upload.blade.php
```

⚠️ ***Acceptable***
```shell
article_comment.blade.php
file_upload.blade.php
```

❌ ***Bad***
```shell
article_comment.blade.php
file-upload.blade.php
```

### 2.1.6 Controllers
Controllers that control a resource MUST use the plural resource name.

✅ ***Good***
```php
class PostsController extends Controller
{
    // ...
}
```

❌ ***Bad***
```php
class PostController extends Controller
{
    // ...
}
```

When writing non-resourceful controller you MUST use {Action}Controller naming with correct words position.

✅ ***Good***
```php
class FileUploadController extends Controller
{
    // ...
}
```

❌ ***Bad***
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

✅ ***Good***
```php
class FileUploadController extends Controller
{
    public function store(FileUploadRequest $request): Response
    {
        // 
    }
}
```

❌ ***Bad***
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

✅ ***Good***
```php
class UserRequest extends FormRequest
{
    // ...
}
```
✅ ***Good***
```php
class UserForm extends Form
{
    // ...
}
```

❌ ***Bad***
```php
class UsersRequest extends FormRequest
{
    // ...
}
```
❌ ***Bad***
```php
class UsersForm extends Form
{
    // ...
}
```

### 2.1.8 Resources
Eloquent Resources MUST use the singular resource name.

✅ ***Good***
```php
class UserResource extends Resource
{
    // ...
}
```
✅ ***Good***
```php
class UserCollectionResource extends CollectionResource
{
    // ...
}
```

❌ ***Bad***
```php
class UsersResource extends Resource
{
    // ...
}
```
❌ ***Bad***
```php
class UsersCollectionResource extends Resource
{
    // ...
}
```

### 2.2 Validation
When using multiple rules for one field in a form request, avoid using `|`, you SHOULD always use array notation.
Using an array notation will make it easier to apply custom rule classes to a field and resolve conflicts.

✅ ***Good***
```php
public function rules(): array
{
    return [
        'email' => ['required', 'email'],
    ];
}
```

⚠️ ***Acceptable***
```php
public function rules(): array
{
    return [
        'name' => 'required',
    ];
}
```

❌ ***Bad***
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

✅ ***Good***
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

❌ ***Bad***
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

✅ ***Good***
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

❌ ***Bad***
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
