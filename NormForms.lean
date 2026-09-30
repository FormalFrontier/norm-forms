/-
Licensed under the Apache License, Version 2.0 (see LICENSE).
Authors: Formal Frontier Agents
-/
module

public import NormForms.Coordinate
public import NormForms.CoordinateNormIteration
public import NormForms.PaddedSubstitution
public import NormForms.CommonZeroCompression
public import NormForms.UniversalCoordinates
public import NormForms.HomogeneousSystemZeros
public import NormForms.AlgebraicExtensionFormZeros
public import NormForms.RatFuncFormZeros
public import NormForms.FiniteTranscendenceFormZeros
public import NormForms.FiniteFieldFormZeros

/-! Coordinate norm forms, universal base-change norms, unbounded attained-degree anisotropic
forms, finite polynomial-equation compression at coefficient-field points, and
equal-degree homogeneous-system common zeros under a single-form bound, including
nontrivial homogeneous-form zeros after arbitrary algebraic field extension and
over rational-function fields at the one-higher-exponent bound, and over
finite-transcendence-degree extensions at the degree-shifted bound;
finite-field common zeros follow from strict degree-sum bounds. -/

set_option warningAsError true
