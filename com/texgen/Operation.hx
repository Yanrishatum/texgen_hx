package com.texgen;

/** Operation type for passing. */
enum Operation
{
  /** A / B */
  Divide;
  /** A + B */
  Add;
  /** A - B */
  Substract;
  /** A * B */
  Multiply;
  /** A ^ B */
  Xor;
  /** A | B */
  Or;
  /** A & B */
  And;
  /** A > B ? A : B */
  Max;
  /** A < B ? A : B */
  Min;
  /** A = B. */
  Set;
  /** Custom operation function */
  Custom(fn:Float->Float->Float);
}
