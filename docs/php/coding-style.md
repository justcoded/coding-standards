# Coding Style

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL"
in this document are to be interpreted as described in [RFC 2119](https://datatracker.ietf.org/doc/html/rfc2119).

## Overview

This specification extends [PER-1 Coding Style 2.0](https://www.php-fig.org/per/coding-style/).
Please read it carefully first. 


### 1. Strict types
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

### 4. Typehints and Return types
Class properties and function / method arguments MUST have type specified.
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

### 5. Docblocks
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

If your array or collection has a few fixed keys, you can typehint them too using {} notation.

:white_check_mark: ***Good***
```php
/**
* @return array{email: string, name: string, age: int}
*/
function getUserData(array $users): void 
{

}
```

### 6. Constructor property promotion
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

### 7. Strings
When possible prefer string interpolation above `sprintf` and the `.` operator.

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

### 8. Ternary operators
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


### 9. If statements
#### 9.1 Brackets
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

#### 9.2 Multiline conditions
Logical operators SHOULD be at the beginning of the line. 

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

#### 9.2 Happy Path
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

#### 9.3 Avoid else
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

### 10. Line breaks
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


### 11. Spaces and alignment
#### 11.1 Unary `!`
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

#### 11.2 Arrays
Arrays MUST use short syntax.

:white_check_mark: ***Good***
```php
['foo' => 'bar', 'foobar' => 'baz']
```

:x: ***Bad***
```php
array('foo' => 'bar', 'foobar' => 'baz');
```

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



### 12 Closures and wrapping
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
        function(Relation $query): Builder {
            return $query
                ->whereIn(Article::table() . '.status', [
                    ArticeStatus::SCHEDULED->value,    
                    ArticeStatus::PUBLISHED->value,    
                ])
                ->has('comments');
    });
```

:warning: ***Acceptable***
```php
User::active()->whereHasMorph(
        'entity', 
        Article::class, 
        fn(Relation $query): Builder => 
            $query
               ->whereIn(Article::table() . '.status', [
                    ArticeStatus::SCHEDULED->value,    
                    ArticeStatus::PUBLISHED->value,    
                ])
                ->has('comments');
        },
    );
```
