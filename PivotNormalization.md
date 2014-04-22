## Pivot Normalization

Okay so cosine normalization isn't perfect. For smaller documents it's often weighting them
too much, and for larger documents it can underweight them. Could we find a magical length
for when cosine normalization to set as the radius for the circle.

* Note: There isn't a "magical" formula for finding this, you just have to run it over your collection.

In the textbook a linear transformation with an alpha of `0.75` we had an `11.7%` improvement
to amplify the documents returned. Basically, cosine normalization isn't perfect, and you
should use only use it as a starting point.
