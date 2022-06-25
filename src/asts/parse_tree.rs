use std::marker::PhantomData;

pub struct Param<'a> {
    name: &'a str, 
    ty: Type<'a>
}

pub enum Mutability {
    Mut,
    Const
}

pub enum Statements<'a> {
    AssignDecl(Mutability, Type<'a>),
    Assign(&'a str),
}

pub enum Body<'a> {
   Statements(Vec<Statements<'a>>),
}

pub struct Function<'a> {
    name: &'a str, 
    params: Param<'a>, 
    retty: Type<'a>,
    bodies: Vec<Body<'a>>,

}

pub struct AggregateTypes<'a> {
    name: &'a str
}

pub enum Type<'a> {
    TyUnit,
    TyU8, 
    TyU32, 
    TyI8, 
    TyI32, 
    Aggregate(&'a str),
}

pub struct Module<'a> {
    filename: &'a str,
    name: &'a str, 
    functions: Vec<Function<'a>>, 
    aggregates: Vec<AggregateTypes<'a>>,
}
