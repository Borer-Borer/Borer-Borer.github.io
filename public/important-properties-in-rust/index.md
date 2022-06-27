# Important Properties in Rust


1.mutable & immutable & Shadowing & const

2.Statements & Expressions & Rust is expression-based language.

3.let ..if..

4.loop label & break/continue expression/loop label

5.for..in..

6.unit type(`()`)

7.Ownership
- Ownership Rules
    - Each value in Rust has a variable that's called its owner.
    - There can only be one owner at a time.
    - When the owner goes out of scope, the value will be dropped.
- move & clone & copy(Copy trait) & reference & slice
- 元组返回多个值,无值返回默认返回单元类型(`()`)
- 规避数据竞争：不可变引用`&` 和 可变引用`&mut`(在特定作用域中的特定数据只能有一个可变引用，且此时不能拥有不可变引用).在最后一行代码不使用的地方释放作用域。
- We call having references as function parameters borrowing
- 引用必须总是有效的。
- slice:&[starting_index..ending_index];`&str`--不可变引用

8.Struct
- `struct`
- field init shorthand
- struct update syntax(User{...., ..., ..user1})
- tuple structs:`struct Point(i32,i32,i32)`
- unit-like structs:`struct Unit`
- 在结构体中存储一个引用而不指定生命周期将是无效的。
- 方法：`impl`,`&self`,`self`,`&mut self`
- automatic referencing and dereferencing.
- associated functions：不以`self`作为参数的函数。`::`
- 每个结构体允许拥有多个`impl`块
- 匿名结构体：`{a:.., b:..,}`

9.Enums
- variants,
- `enum IpAddr{V4(u8,u8,u8,u8),V6(String)}`,variant:`IpAddr::V4(127,0,0,1)`属于IpAddr自定义数据类型。`enum Message{Quit,Move{x:i32,y:i32},Write(String),Color(i32,i32,i32)}`
- 方法：`impl`,`&self`,`self`,`&mut self`
- Option<T>:
    - `enum Option<T>{ Some(T),None }`
    - 只要一个值不是Option<T>，你就可以认定它的值不为空。

10.`match`控制流运算符
- exhaustive
- `_`匹配所有的值
- `if let`(..`else`)只匹配一个模式的值而忽略其他模式的情况,使用`=`分割一个模式和一个表达式。

11.The mudules system
- packages & crates
    - 一个包(package)中至多只能包含一个库crate（library crate）；包中可以包含任意多个二进制crate（binary crate）；包中至少包含一个crate,无论是库的还是二进制的。
    - `cargo new binary-crate-package`===>`src/main.rs`-->crate root & `cargo new --lib library-crate-package`===>`src/lib.rs`-->crate root.
- modules
    - 将一个crate中的代码进行分组。
    - 控制项的`私有性`即可以被外部代码使用（public），还是内部实现的不能被外部代码使用（private）。
    - Rust 中默认所有项（函数、方法、结构体、枚举、模块和常量）都是私有的。父模块中的项不能使用子模块中的私有项，但是子模块中的项可以使用他们父模块中的项。
    - `pub`:使子模块的内部部分暴露给上级模块。
    - `siblings`,`child`,`parent`;Notice that the entire module tree is rooted under the implicit module named `crate`.
    - 如果我们在一个结构体定义的前面使用了 pub ，这个结构体会变成公有的，但是这个结构体的字段仍然是私有的。字段共有需要字段前加`pub`.
    - 如果我们将枚举设为公有，则它的所有成员都将变为公有。
    - `use` Bringing Paths into Scope---bring a name into scope.---the name available in the new scope is private.---->`pub use`re-exporting---This technique is called re-exporting because we’re bringing an item into scope but also making that item available for others to bring into their scope.;;;`as`Providing New Names.
    - `use std::io::{self,Write};`.glob运算符：`use std::collections::*;`
    - `mod` 关键字声明了模块，Rust 会在与模块同名的文件中查找模块的代码。
    - `pub`,`mod`,`super`,`use`,`pub use`,`as`
- paths
    - absolute path:`crate::..::..`;relative path:`self/super::..::..`
    -  `"src/front_of_house.rs" or "src/front_of_house/mod.rs"` & `"src/front_of_house/hosting.rs" or "src/front_of_house/hosting/mod.rs"`

12.Collections(数据结构)
- The data these collections point to is stored on the heap, which means the amount of data does not need to be known at compile time and can grow or shrink as the program runs.
- Vector(Vec<T>)
    - 相邻排列所有值，存储相同类型的值.
    - `let v:Vec<i32>=Vec::new();` & `let v=vec![1,2,3];` & `v.push(3);` & `let third:&i32=&v[2];` & `let does_not_exist=v.get(100);` & `for i in &mut v{ *i+=59; }` & `v.pop()` & `enum + vector 实现vec中存放不同类型的数据（但其都是enum的一个类型）`
    -  vector 的工作方式：在 vector 的结尾增加新元素时，在没有足够空间将所有所有元素依次相邻存放的情况下，可能会要求分配新内存并将老的元素拷贝到新的空间中。
- String(UTF-8编码的)
    - 字符串就是作为字节的集合外加一些方法实现的.它是可增长的、可变的、有所有权的、UTF-8 编码的字符串类型。Rust 的核心语言中只有一种字符串类型：str，字符串 slice，它通常以被借用的形式出现，`&str`。
    - `String::from("hello")`<==>`"hello".to_string()`==>`String::new()` & `s.push(s2)`==>`s.push_str(s2)`==>`s3=s+&s2`->`fn add(self,s:&str)->String{}`->`deref coercion`->`String-->&str`-->`&s2-->&s2[..]`==>`let s=format!("{}-{}-{}",s1,s2,s3);`-->不会获取所有权 & `let s = &hello[0..4]`-->`小心使用` & `for c in s.chars(){}`===>`for b in s.bytes(){}`
    - `String` 是一个 `Vec<u8>`的封装。
    - 有效的 Unicode 标量值可能会由不止一个字节组成。
- Hash map
    - HashMap<K,V>:存储一个键类型K对应一个值类型V的映射。可以用任何类型作为键。哈希 map 是同质的：所有的键必须是相同类型，值也必须都是相同类型。
    - `let mut scores=HashMap::new()`==>`let scores:HashMap<_,_>=tems.iter().zip(initial_scores.iter()).collect();`-->teams和initial_scores是元组的vector & `scores.insert(String::form("blue"),10);` & `scores.get("Bule")` & `for (key,value) in &scores {}` & `scores.entry(String::from("Yellow")).or_insert(55);`
    - Hashing Functions

13.Error Handling
- `recoverable errors`-->`Result<T,E>`
    - `panic!`:`unwinding`-->Rust walks back up the stack and cleans up the data.===>`abort`:ending the program without cleaning up.cleaned up by operating system.===>`switch from unwinding to aborting`:adding `panic='abort'` to the appropriate [profile] sections in your Cargo.toml file.
    - `panic!`的`backtrace`：`backtrace`是一个执行到目前位置所有被调用的函数列表；RUST_BACKTRACE=1;必须其用debug标识才可以获取到`backtrace`，不使用`--release`参数运行`cargo build`或`cargo run`时，debug标识默认启用.
- `unrecoverable errors`-->`panic!`
    - `enum Result<T,E>{Ok(T),Err(E),}`-->`unwrap`,`expect`
    - A Shortcut for Propagating Errors: the `?` Operator

14.Generic Types,Traits,Lifetimes
- Generic Types
    - 泛型是具体类型或其他属性的抽象替代。
    - `fn largest<T>(list:&[T])->T{}`
    - `struct Point1<T>{x:T,y:T,}` `struct Point2<T,U>{x:T,y:U,}`
    - `enum Option<T>{Some(T),None,}` `enum Result<T,E>{Ok(T),Err(E),}`
    - `impl<T> Point1<T>{fn x(&self)->&T{&self.x}}` `impl<T,U> Point2<T,U>{fn mixup<V,W>(self,other:Point<V,W>)->Point(T,W){...}}`
    - monomorphization:单态化是一个通过填充编译时使用的具体类型，将通用代码转换为特定代码的过程。

- Trait
    - 告诉Rust编译器某个特定类型拥有可能与其他类型共享的功能。trait 定义是一种将方法签名组合起来的方法，目的是定义一个实现某些目的所必需的行为的集合。
    - `pub trait Summary{ fn summarize(&self)->String; fn...; fn ss()->String{String::from("hello")} }` & `impl Summary for Point1{ fn summary(&self)->String{.....} }` & `impl Summary for Point2{ fn summary(&self)->String{.....} }` & `point.summarize()`
    - *coherence*/*orphanrule* : One restriction to note with trait implementations is that we can implement a trait on a type only if either the trait or the type is local to our crate.But we can’t implement external traits on external types.
    - 默认实现允许调用相同 trait 中的其他方法，哪怕这些方法没有默认实现。Note that it isn’t possible to call the `default implementation` from an overriding implementation of that same method.
    - `Traits as Parameters`：`pub fn notify(item:&impl Summary){.....item.summarize()}`-->`pub fn notify(item:&(impl Summary+Display)){....}`==`Trait Bound` Syntax==>`pub fn notify<T:Summary>(item:&T){....item.summarize()}`-->`pub fn notify<T:Summary>(item1:&T,item2:&T){...item.summarize()}`-->`pub fn notify<T:Summary+Display>(item:&T){....}`-->`fn some_function<T,U>(t:&T,u:&U)->i32 where T:Display+Clone,U:Clone+Debug{...}`
    - `Returning Types that Implement Traits`：`fn returns_ss(...)->impl Summary{只能返回一个实现了Summary的类型}`
    - `blanket implementations`：Implementations of a trait on any type that satisfies the trait bounds are called blanket implementations and are extensively used in the Rust standard library.`impl<T:Display+PartialOrd> Pair<T>{}`-->`impl<T:Display> ToString for T{..}`
    - `trait`，`for`


- Lifetimes
    - lifetimes ensure that `references` are valid as long as we need them to be. every reference in Rust has a lifetime, which is the scope for which that reference is valid.其主要目的避免悬垂指针。
    - lifetimes are a type of generic.
    - `borrow checker`:比较作用域确保所有的借用都是有效的。
    - `Lifetime Annotation Syntax`:`'`==>`&i32`,`&'a i32`,`&'a mut i32`
    - `Generic Lifetimes in Functions`：`fn longest<'a>(x:&'a str,y:&'a str)->&'a str{...}`==>The concrete lifetime that is substituted for `'a` is the part of the scope of `x` that overlaps with the scope of `y`.==>Remember, when we specify the lifetime parameters in this function signature, we’re not changing the lifetimes of any values passed in or returned. Rather, we’re specifying that the borrow checker should reject any values that don’t adhere to these constraints.==>lifetime syntax is about connecting the lifetimes of various parameters and return values of functions. 
    - `Lifetime Annotations in Struct Definitions`：`struct ImportantExcerpt<'a>{ part:&'a str, }`-->This annotation means an instance of ImportantExcerpt can’t outlive the reference it holds in its part field.
    - `Lifetime Annotations in Method Definitions`：`impl<'a> ImportantExcerpt<'a>{ fn level(&self,aa:&str)->&str{...} }`
    - The Static Lifetime：`'static`==>` let s: &'static str = "I have a static lifetime."; `==>this reference can live for the entire duration of the program. 
    - Lifetime Elision
        - Lifetimes on function or method parameters are called `input lifetimes`, and lifetimes on return values are called `output lifetimes`.
        - lifetime elision rules:
            - each parameter that is a reference gets its own lifetime parameter.
            -  if there is exactly one `input lifetime` parameter, that lifetime is assigned to all `output lifetime` parameters: `fn foo<'a>(x: &'a i32) -> &'a i32`.
            -  if there are multiple `input lifetime` parameters, but one of them is `&self` or `&mut self` because this is a method, the lifetime of self is assigned to all `output lifetime` parameters.
    - Example:`fn longest_with_an_anno<'a,T>(x:&'a str,y:&'a str,ann:T,)->&'a
    str where T:Display,{...}`

15.Automated Tests
- `#[test]`==>`#[should_panic]`==>`#[ignore]`==>`cargo test`-->`cargo test -h`==>`assert!`,`assert_eq!`,`assert_ne!`
- `#[derive(PartialEq,Debug)]`

- 文档测试
- Each test is run in a new thread, and when the main thread sees that a test thread has died, the test is marked as failed. 

16.Command Line Program
- `let args: Vec<String> = env::args().collect();`
- `env::var("CASE_INSENSITIVE").is_err();`
- `eprintln!`

17.Functional Language Features: Iterators and Closures
- Closures
    - Rust’s closures are anonymous functions you can save in a variable or pass as arguments to other functions.You can create the closure in one place and then call the closure to evaluate it in a different context. Unlike functions, closures can capture values from the scope in which they’re defined.
    - `|param1,param2|{...}`-->`|param1:u32,param2|->u32{...}`-->Closures don’t require you to annotate the types of the parameters or the return value like fn functions do. 
    - `lazy evaluation`: All closures implement at least one of the traits: Fn, FnMut, or FnOnce.`struct Cacher<T> where T:Fn(u32)->u32{..}` `impl<T> Cacher<T> where T:Fn(u32)->u32{...}`
    - closures have an additional capability that functions don’t have: they can capture their environment and access variables from the scope in which they’re defined.-->`FnOnce`,`FnMut`,`Fn`==>`move`
    - we don’t want to call it if the result isn’t needed, and we still want to call it only once.
- Iterator
    - An iterator is responsible for the logic of iterating over each item and determining when the sequence has finished.In Rust, iterators are lazy, meaning they have no effect until you call methods that consume the iterator to use it up. Iterators give you more flexibility to use the same logic with many different kinds of sequences, not just data structures you can index into, like vectors.













others:
- `prelude`
- Test Driven Development(TDD)

