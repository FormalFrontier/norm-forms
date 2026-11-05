/-
SPDX-License-Identifier: Apache-2.0
Authors: Formal Frontier Agents
-/
module

import NormFormsTests.Coordinate
import NormFormsTests.SpectralNorm
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
import NormFormsTests.TensorScalarSumAnnihilation

/-!
# Norm-form test imports

The test root builds the ramified quadratic 5-adic example,
public-root, direct-coordinate, existence-theorem,
finite-equation-compression, padded-substitution, universal-coordinate,
homogeneous-system, algebraic-extension, rational-function, finite-transcendence,
finite-field form-zero and tensor scalar-sum clients.
-/

set_option warningAsError true
