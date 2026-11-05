/-
SPDX-License-Identifier: Apache-2.0
Authors: Formal Frontier Agents
-/
module

public import NormForms.Coordinate
public import NormForms.SpectralNorm
public import NormForms.CoordinateNormIteration
public import NormForms.PaddedSubstitution
public import NormForms.CommonZeroCompression
public import NormForms.UniversalCoordinates
public import NormForms.IdealCongruence
public import NormForms.HomogeneousSystemZeros
public import NormForms.AlgebraicExtensionFormZeros
public import NormForms.RatFuncFormZeros
public import NormForms.FiniteTranscendenceFormZeros
public import NormForms.FiniteFieldFormZeros
public import NormForms.TensorScalarSumAnnihilation
public import NormForms.TraceCongruence

/-! Field-norm/spectral-norm comparison over complete ultrametric fields,
coordinate norm forms, universal base-change norms, norm congruences modulo extended ideals,
unbounded attained-degree anisotropic forms, finite polynomial-equation compression
at coefficient-field points, and
equal-degree homogeneous-system common zeros under a single-form bound, including
nontrivial homogeneous-form zeros after arbitrary algebraic field extension and
over rational-function fields at the one-higher-exponent bound, and over
finite-transcendence-degree extensions at the degree-shifted bound;
finite-field common zeros follow from strict degree-sum bounds; positive tensor powers
admit surjective scalar sums annihilating finite families of arbitrary tensors under
a strict finite-target dimension bound. Norms agree to first order with one plus
the trace modulo squares of arbitrary base ideals. -/

set_option warningAsError true
