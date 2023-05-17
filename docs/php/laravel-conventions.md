# Laravel conventions

## 1. Case usage and naming
### 1.1 Class names
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

### 1.2 Artisan commands
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

### 1.3 Config files
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

### 1.4 Routes
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

### 1.5 Views
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

### 1.6. Controllers
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

### 1.7. FormRequests and Forms
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

### 1.8. Resources
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

### 2. Validation
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

### 3. Livewire
#### 3.1 `render()`
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

#### 3.2 `mount()`
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
