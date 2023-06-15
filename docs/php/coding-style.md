# Coding Style

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL"
in this document are to be interpreted as described in [RFC 2119](https://datatracker.ietf.org/doc/html/rfc2119).

## Overview

⚠️ This specification extends **[PER Coding Style 2.0](https://www.php-fig.org/per/coding-style/)**.
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

✅ ***Good***
```php
<?php

declare(strict_types=1);

namespace Vendor\Package;
```

❌ ***Bad***
```php
<?php

namespace Vendor\Package;
```

### 2. Import statements 
See [PER](https://www.php-fig.org/per/coding-style/#3-declare-statements-namespace-and-import-statements)  
Grouping imports SHOULD NOT be used as it's harder to maintain and can lead to git conflicts.

✅ ***Good***
```php
<?php

declare(strict_types=1);

namespace Vendor\Package;

use Vendor\Package\ClassA as A;
use Vendor\Package\ClassB;
use Vendor\Package\ClassC as C;
```

❌ ***Bad***
```php
<?php

declare(strict_types=1);

namespace Vendor\Package;

use Vendor\Package\{ClassA as A, ClassB, ClassC as C};
```

### 3. FQN vs Import
See [PER](https://www.php-fig.org/per/coding-style/#3-declare-statements-namespace-and-import-statements)  
Classes, Interfaces and Traits SHOULD always be imported.  
Namespaced functions SHOULD be imported and MUST have an alias prefixed by vendor or package.

✅ ***Good***
```php
<?php

declare(strict_types=1);

namespace Vendor\Package;

use ClassB;
use Exception;
use function Vendor\Package\check_condition as vendor_check_condition;

class ClassA extends ClassB
{
    public function foo() 
    {
        if (! vendor_check_condition($condition)) {
            throw new Exception('....');
        }
    } 
}
```

❌ ***Bad***
```php
<?php

declare(strict_types=1);

namespace Vendor\Package;

class ClassA extends \ClassB
{
    public function foo() 
    {
        if (! \Vendor\Package\check_condition($condition)) {
            throw new \Exception('....');
        }
    } 
} 

```
❌ ***Bad***
```php
<?php

declare(strict_types=1);

namespace Vendor\Package;

use ClassB;
use Exception;
use function Vendor\Package\check_condition;

class ClassA extends ClassB
{
    public function foo() 
    {
        if (! check_condition($condition)) {
            throw new Exception('....');
        }
    } 
}
```

### 4. Constructor property promotion
See [PER](https://www.php-fig.org/per/coding-style/#44-methods-and-functions)  
Use constructor property promotion. To make it readable, they MUST be put each one on a line of its own (multiline). Use a comma after the last one.

✅ ***Good***
```php
class EmailAddress 
{
    public function __construct(
        public readonly string $email,
        public readonly ?string $name,
    ) {}
}

```

❌ ***Bad***
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

⚠️ ***Acceptable***
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

✅ ***Good***
```php
$greeting = "Hi, I am {$name}.";
```
❌ ***Bad***
```php
$greeting = 'Hi, I am ' . $name . '.';
```

❌ ***Bad***
```php
$greeting = sprintf('Hi, I am %s.', $name);
```

❌ ***Bad***
```php
$greeting = "Hi, I am $name.";
```

### 6. Ternary operators
See [PER](https://www.php-fig.org/per/coding-style/#63-ternary-operators)  
Every portion of a ternary expression should be on its own line unless it's a really short expression.

✅ ***Good***
```php
$price = $user->isVip() ? $product->priceWithVipDiscount() : $product->price();
```
✅ ***Good***
```php
$userData = $user instanceof AdminUser 
    ? [...$user->publicData(), ...$user->sensitiveData()] 
    : $user->publicData();
```

You MUST NOT use nested ternary operators.

✅ ***Good***
```php
if ($age < 13) {
    return 'child';
}

return $age < 18 ? 'teenager' : 'adult';
```

❌ ***Bad***
```php
return $age < 13 ? 'child' : ($age < 18 ? 'teenager' : 'adult');
```

### 7. If statements
See [PER](https://www.php-fig.org/per/coding-style/#51-if-elseif-else)  
#### 7.1 Brackets
Curly brackets MUST always be used.

✅ ***Good***
```php
if ($condition) {
    //
}
```

❌ ***Bad***
```php
if ($condition) // ..
```

#### 7.2 Multiline conditions
Logical operators MUST be at the beginning of the line. 
Same rules MUST be followed for `switch` statement ([PER](https://www.php-fig.org/per/coding-style/#52-switch-case-match)).

✅ ***Good***
```php
if (
    $conditionA
    && $condtionB
    && $conditionC
) {
    //
}
```

❌ ***Bad***
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

✅ ***Good***
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

❌ ***Bad***
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

✅ ***Good***
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

✅ ***Good***
```php
if ($foo) {
    $this->foo = $foo;
}
```

❌ ***Bad***
```php
if ($foo) {

    $this->foo = $foo;
}
```

### 9. Spaces and alignment
#### 9.1 Unary `!`
Unary "not" SHOULD be followed by space.

✅ ***Good***
```php
if (! $condition) {
    // 
}
```

❌ ***Bad***
```php
if (!$condition) {
    //
}
```

#### 9.2 Arrays
See [PER](https://www.php-fig.org/per/coding-style/#11-arrays)  
Arrays SHOULD NOT be aligned. 
There MUST NOT be mixed alignment style for same project.

✅ ***Good***
```php
[
    'foo' => 'bar', 
    'foobar' => 'baz',
];
```

⚠️ ***Acceptable***
```php
[
    'foo'    => 'bar', 
    'foobar' => 'baz',
];
```

### 10. Closures and wrapping
See [PER](https://www.php-fig.org/per/coding-style/#7-closures)  
When deal with Closures and wrapping you SHOULD follow next styling.

✅ ***Good***
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

✅ ***Good***
```php
User::active()->with([
    'posts' => fn(Builder $query): Builder => $query->whereHas(
        'comments',
        fn(Relation $query): Builder => $query->where(...),
    )
]);
```

✅ ***Good***
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

✅ ***Good***
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

✅ ***Good***
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

⚠️ ***Acceptable***
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

❌ ***Bad***
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

❌ ***Bad***
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
