/-
Licensed under the Apache License, Version 2.0 (see LICENSE).
Authors: Formal Frontier Agents
-/
module

import NormFormsTests.Coordinate
import NormFormsTests.DirectAPI
import NormFormsTests.Axioms
import NormFormsTests.CoordinateNormIteration
import NormFormsTests.CommonZeroCompression
import NormFormsTests.PaddedSubstitution
import NormFormsTests.UniversalCoordinates
import NormFormsTests.HomogeneousSystemZeros
import NormFormsTests.AlgebraicExtensionFormZeros
import NormFormsTests.RatFuncFormZeros
import NormFormsTests.FiniteTranscendenceFormZeros
import NormFormsTests.FiniteFieldFormZeros

/-!
# Norm-form test imports

The test root builds the public-root, direct-coordinate, existence-theorem,
finite-equation-compression, padded-substitution, universal-coordinate,
homogeneous-system, algebraic-extension, rational-function, finite-transcendence
and finite-field form-zero clients
with selected axiom prints; it is not a private/generated-declaration audit.
-/

set_option warningAsError true
