## Naming and other conventions

### 1. Artisan Commands
The names given to artisan commands MUST all be kebab-cased.

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

### 2. Config
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

### 3. Controllers
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

### 4. FormRequests and Forms
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

### 5. Resources
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

### 6. Routing
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

Controllers SHOULD use CRUD methods.

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

### 7. Views
Views should use `kebab-case`

:white_check_mark: ***Good***
```shell
file-upload.blade.php
```

:x: ***Bad***
```shell
file_upload.blade.php
```

### 8. Validation
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

### 8. Livewire
#### 8.1 `render()`
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

#### 8.2 `mount()`
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
