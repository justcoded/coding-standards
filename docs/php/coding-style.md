# Coding Style

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL"
in this document are to be interpreted as described in [RFC 2119](https://datatracker.ietf.org/doc/html/rfc2119).

## Overview

This specification extends [PER Coding Style 2.0](https://www.php-fig.org/per/coding-style/).
Please read it carefully first.

### Table of contents
- [1. Strict types](#1-strict-types)
- [2. Import statements](#2-import-statements)
- [3. FQN vs Import](#3-fqn-vs-import)
- [4. Constructor property promotion](#4-constructor-property-promotion)
- [5. Strings](#5-strings)
- [6. Ternary operators](#6-ternary-operators)
- [7. If statements](#7-if-statements)
    * [7.1 Brackets](#71-brackets)
    * [7.2 Multiline conditions](#72-multiline-conditions)
- [8. Line breaks](#8-line-breaks)
- [9. Spaces and alignment](#9-spaces-and-alignment)
    * [9.1 Unary `!`](#91-unary-)
    * [9.2 Arrays](#92-arrays)
- [10. Closures and wrapping](#10-closures-and-wrapping)

### 1. Strict types 
See [PER](https://www.php-fig.org/per/coding-style/#3-declare-statements-namespace-and-import-statements)  
All php only files MUST have `declare(strict_types=1);` statement.

:white_check_mark: ***Good***
```php
<?php

declare(strict_types=1);

namespace Vendor\Package;
```

:x: ***Bad***
```php
<?php

namespace Vendor\Package;
```

### 2. Import statements 
See [PER](https://www.php-fig.org/per/coding-style/#3-declare-statements-namespace-and-import-statements)  
Grouping imports SHOULD NOT be used as it's harder to maintain and can lead to git conflicts.

:white_check_mark: ***Good***
```php
<?php

declare(strict_types=1);

namespace Vendor\Package;

use Vendor\Package\ClassA as A;
use Vendor\Package\ClassB;
use Vendor\Package\ClassC as C;
```

:x: ***Bad***
```php
<?php

declare(strict_types=1);

namespace Vendor\Package;

use Vendor\Package\{ClassA as A, ClassB, ClassC as C};
```

### 3. FQN vs Import
See [PER](https://www.php-fig.org/per/coding-style/#3-declare-statements-namespace-and-import-statements)  
Classes, Interfaces and Traits SHOULD always be imported.

:white_check_mark: ***Good***
```php
<?php

declare(strict_types=1);

namespace Vendor\Package;

use ClassB;
use Exception;

class ClassA extends ClassB
{
    public function foo() 
    {
        if (! $condition) {
            throw new Exception('....');
        }
    } 
}
```

:x: ***Bad***
```php
<?php

declare(strict_types=1);

namespace Vendor\Package;

class ClassA extends \ClassB
{
    public function foo() 
    {
        if (! $condition) {
            throw new \Exception('....');
        }
    } 
} 

```

### 4. Constructor property promotion
See [PER](https://www.php-fig.org/per/coding-style/#44-methods-and-functions)  
Use constructor property promotion. To make it readable, they MUST be put each one on a line of its own (multiline). Use a comma after the last one.

:white_check_mark: ***Good***
```php
class EmailAddress 
{
    public function __construct(
        public readonly string $email,
        public readonly ?string $name,
    ) {}
}

```

:x: ***Bad***
```php
class EmailAddress 
{
    public readonly string $email;
    
    public readonly ?string $name;

    public function __construct(string $email, ?string $name) 
    {
        $this->email = $email;
        $this->name = $name;    
    }
}
```

You MAY combine property promotion and classic syntax.

:warning: ***Acceptable***
```php
class EmailAddress 
{
    public readonly string $email;
    
    public readonly string $name;

    public function __construct(
        public readonly string $email, 
        ?string $name = null,
    ) {
        $this->name = $name ?? str($this->email)->before('@')->title()->toString();    
    }
}
```

### 5. Strings
When possible you SHOULD use string interpolation instead of `sprintf` and the `.` operator.
Always use brackets `{}` around variables.

:white_check_mark: ***Good***
```php
$greeting = "Hi, I am {$name}.";
```
:x: ***Bad***
```php
$greeting = 'Hi, I am ' . $name . '.';
```

:x: ***Bad***
```php
$greeting = sprintf('Hi, I am %s.', $name);
```

:x: ***Bad***
```php
$greeting = "Hi, I am $name.";
```

### 6. Ternary operators
See [PER](https://www.php-fig.org/per/coding-style/#63-ternary-operators)  
Every portion of a ternary expression should be on its own line unless it's a really short expression.

:white_check_mark: ***Good***
```php
$price = $user->isVip() ? $product->priceWithVipDiscount() : $product->price();
```
:white_check_mark: ***Good***
```php
$userData = $user instanceof AdminUser 
    ? [...$user->publicData(), ...$user->sensitiveData()] 
    : $user->publicData();
```

You MUST NOT use nested ternary operators.

:white_check_mark: ***Good***
```php
if ($age < 13) {
    return 'child';
}

return $age < 18 ? 'teenager' : 'adult';
```

:x: ***Bad***
```php
return $age < 13 ? 'child' : ($age < 18 ? 'teenager' : 'adult');
```

### 7. If statements
See [PER](https://www.php-fig.org/per/coding-style/#51-if-elseif-else)  
#### 7.1 Brackets
Curly brackets MUST always be used.

:white_check_mark: ***Good***
```php
if ($condition) {
    //
}
```

:x: ***Bad***
```php
if ($condition) // ..
```

#### 7.2 Multiline conditions
Logical operators MUST be at the beginning of the line. 
Same rules MUST be followed for `switch` statement ([PER](https://www.php-fig.org/per/coding-style/#52-switch-case-match)).

:white_check_mark: ***Good***
```php
if (
    $conditionA
    && $condtionB
    && $conditionC
) {
    //
}
```

:x: ***Bad***
```php
if (
    $conditionA &&
    $condtionB &&
    $conditionC
) {
    //
}
```

### 8. Line breaks
Statements SHOULD be allowed to breathe.
In general, you SHOULD always add blank lines between statements, unless they're a sequence of single-line equivalent operations.

:white_check_mark: ***Good***
```php
public function getPage($url)
{
    $page = $this->pages()->where('slug', $url)->first();

    if (! $page) {
        return null;
    }

    if ($page['private'] && ! Auth::check()) {
        return null;
    }

    return $page;
}
```

:x: ***Bad***
```php
// Everything's cramped together.
public function getPage($url)
{
    $page = $this->pages()->where('slug', $url)->first();
    if (! $page) {
        return null;
    }
    if ($page['private'] && ! Auth::check()) {
        return null;
    }
    return $page;
}
```

:white_check_mark: ***Good***
```php
// A sequence of single-line equivalent operations.
public function up()
{
    Schema::create('users', function (Blueprint $table) {
        $table->increments('id');
        $table->string('name');
        $table->string('email')->unique();
        $table->string('password');
        $table->rememberToken();
        $table->timestamps();
    });
}
```

Don't add any extra empty lines between `{}` brackets.

:white_check_mark: ***Good***
```php
if ($foo) {
    $this->foo = $foo;
}
```

:x: ***Bad***
```php
if ($foo) {

    $this->foo = $foo;
}
```

### 9. Spaces and alignment
#### 9.1 Unary `!`
Unary "not" SHOULD be followed by space.

:white_check_mark: ***Good***
```php
if (! $condition) {
    // 
}
```

:x: ***Bad***
```php
if (!$condition) {
    //
}
```

#### 9.2 Arrays
See [PER](https://www.php-fig.org/per/coding-style/#11-arrays)  
Arrays SHOULD NOT be aligned. 
There MUST NOT be mixed alignment style for same project.

:white_check_mark: ***Good***
```php
[
    'foo' => 'bar', 
    'foobar' => 'baz',
];
```

:warning: ***Acceptable***
```php
[
    'foo'    => 'bar', 
    'foobar' => 'baz',
];
```

### 10. Closures and wrapping
See [PER](https://www.php-fig.org/per/coding-style/#7-closures)  
When deal with Closures and wrapping you SHOULD follow next styling.

:white_check_mark: ***Good***
```php
$query
    ->where(
        fn(Builder $query): Builder => $query->where(
            fn(Builder $query): Builder => $query->whereHas(
              'user',
              fn(Relation $query): Builder => $query->where(...),
            ),
        ),
    )
    ->get();
```

:white_check_mark: ***Good***
```php
User::active()->with([
    'posts' => fn(Builder $query): Builder => $query->whereHas(
        'comments',
        fn(Relation $query): Builder => $query->where(...),
    )
]);
```

:white_check_mark: ***Good***
```php
User::active()->whereHasMorph(
        'entity', 
        Article::class, 
        fn(Relation $query): Builder => $query->whereIn(Article::table() . '.status', [
            ArticeStatus::SCHEDULED->value,    
            ArticeStatus::PUBLISHED->value,    
        ]),
    );
```

:white_check_mark: ***Good***
```php
User::active()->whereHasMorph(
        'entity', 
        Article::class, 
        fn(Relation $query): Builder => $query->whereIn(
            Article::table() . '.status', 
            [
                ArticeStatus::SCHEDULED->value,    
                ArticeStatus::PUBLISHED->value,    
            ],
        ),
    );
```

When closure has more than one statement you SHOULD use classic closure syntax.

:white_check_mark: ***Good***
```php
User::active()->whereHasMorph(
        'entity', 
        Article::class, 
        static function(Relation $query): void {
            $query
                ->whereIn(Article::table() . '.status', [
                    ArticeStatus::SCHEDULED->value,    
                    ArticeStatus::PUBLISHED->value,    
                ])
                ->has('comments'),
        );
```

:warning: ***Acceptable***
```php
User::active()->whereHasMorph(
        'entity', 
        Article::class, 
        static fn(
            Relation $query,
            $otherParam
         ): Builder => $query
           ->whereIn(Article::table() . '.status', [
                ArticeStatus::SCHEDULED->value,    
                ArticeStatus::PUBLISHED->value,    
            ])
            ->has('comments'),
    );
```

The `=>` MUST always have expressions by both sides 

:x: ***Bad***
```php
User::active()->whereHasMorph(
        'entity', 
        Article::class, 
        fn(
            Relation $query,
            $otherParam
         ): Builder
             => $query
                 ->whereIn(Article::table() . '.status', [
                     ArticeStatus::SCHEDULED->value,    
                     ArticeStatus::PUBLISHED->value,    
                 ])
                 ->has('comments'),
    );
```

:x: ***Bad***
```php
User::active()->whereHasMorph(
        'entity', 
        Article::class, 
        fn(
            Relation $query,
            $otherParam
         ): Builder => 
             $query->whereIn(Article::table() . '.status', [
                 ArticeStatus::SCHEDULED->value,    
                 ArticeStatus::PUBLISHED->value,    
             ])
             ->has('comments'),
    );
```
