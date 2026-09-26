/-
Licensed under the Apache License, Version 2.0 (see LICENSE).
Authors: Formal Frontier Agents
-/
module

import NormFormsTests.Coordinate
import NormFormsTests.DirectAPI

/-!
# Selected norm-form axiom prints

The targets are all 18 public production declarations and 11 named test theorems.
This file does not audit private or generated declarations in every shipped module.
-/

set_option warningAsError true

#print axioms NormForms.coordinateNorm
#print axioms NormForms.coordinateNorm_eq_zero_iff
#print axioms NormForms.coordinateNorm_smul
#print axioms NormForms.coordinateChange
#print axioms NormForms.coordinateChange_apply
#print axioms NormForms.coordinateNorm_coordinateChange
#print axioms NormForms.coordinateNormPolynomial
#print axioms NormForms.coordinateNormPolynomial_isHomogeneous
#print axioms NormForms.coordinateNormPolynomial_eval
#print axioms NormForms.coordinateNormPolynomial_eval_eq_zero_iff
#print axioms NormForms.coordinateNormPolynomial_ne_zero
#print axioms NormForms.coordinateNormPolynomial_totalDegree
#print axioms NormForms.coordinateNormPolynomial_eval_coordinateChange
#print axioms NormForms.coordinateNormPolynomial_reindex
#print axioms NormForms.coordinateNorm_reindex
#print axioms NormForms.coordinateChangePolynomial
#print axioms NormForms.coordinateChangePolynomial_eval
#print axioms NormForms.coordinateNormPolynomial_changeBasis

#print axioms NormFormsTests.rational_singleton_norm
#print axioms NormFormsTests.rational_singleton_polynomial
#print axioms NormFormsTests.complex_norm_polynomial
#print axioms NormFormsTests.complex_swap_coordinates
#print axioms NormFormsTests.complex_reindex_polynomial
#print axioms NormFormsTests.complex_changeBasis_eval
#print axioms NormFormsTests.complex_changeBasis_polynomial

#print axioms NormFormsTests.finite_identity_norm_one
#print axioms NormFormsTests.finite_unequal_indices_eval
#print axioms NormFormsTests.finite_unequal_indices_rename
#print axioms NormFormsTests.finite_unequal_indices_substitution
