# String Matching

## Sequence-based metrics

- Edit distance (Levenshtein): Minimum number of changes to transform one string into another. [LN Notes](../../LN/Teoricas/Aula%203%20-%20Evaluation.md#levenshtein-distance)
- Damerau-Levenshtein distance: Similar to edit distance, but considers adjacent characters transposition as one operation. [LN Notes](../../LN/Teoricas/Aula%203%20-%20Evaluation.md#damerau-levenshtein-distance)
- Needleman-Wunsch measure: Similar to edit distance, but with negative scores. Similarity measure.
- Jaro measure: Rewards common sequences characters and penalizes mismatches and transpositions. [LN Notes](../../LN/Teoricas/Aula%203%20-%20Evaluation.md#jaro-distance)
  - $jaro(x,y) = \dfrac{1}{3} \biggl(\dfrac{c}{|x|} + \dfrac{c}{|y|} + \dfrac{c - \dfrac{t}{2}}{c}\biggr) $
- Jaro-Winkler measure: A variant of Jaro for strings with a common prefix.

## Set-based metrics

- Jaccard: number of common bigrams divided by the number of all bigrams. [LN Notes](../../LN/Teoricas/Aula%203%20-%20Evaluation.md#jaccard)

## Phonetic Metrics

- Soundex measure: used primarily to match surnames. [LN Notes](../../LN/Teoricas/Aula%203%20-%20Evaluation.md#soundex)
- Refined Soundex: Uses a different table with more groups and there is no truncation to 4 characters.
  - b, p -> 1
  - f, v -> 2
  - c, k, s, -> 3
  - g, j -> 4
  - q, x, z -> 5
  - d, t -> 6
  - l -> 7
  - m, n -> 8
  - r -> 9