% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/createFeatureObject.R
\name{FeatureObject}
\alias{FeatureObject}
\alias{createFeatureObject}
\title{Create a Feature Object}
\usage{
createFeatureObject(init, X, y, fun, minimize, lower, upper, blocks, objective,
  force = FALSE)
}
\arguments{
\item{init}{[\code{\link{data.frame}}]\cr
A \code{data.frame}, which can be used as initial design. If not provided,
it will be created either based on the initial sample \code{X} and the
objective values \code{y} or \code{X} and the function definition \code{fun}.}

\item{X}{[\code{\link{data.frame}} or \code{\link{matrix}}]\cr
A \code{data.frame} or \code{matrix} containing the initial sample. If not
provided, it will be extracted from \code{init}.}

\item{y}{[\code{\link{numeric}} or \code{\link{integer}}]\cr
A vector containing the objective values of the initial design.
If not provided, it will be extracted from \code{init}.}

\item{fun}{[\code{\link{function}}]\cr
A function, which allows the computation of the objective values. If it is
not provided, features that require additional function evaluations, can't
be computed.}

\item{minimize}{[\code{\link{logical}(1)}]\cr
Should the objective function be minimized? The default is \code{TRUE}.}

\item{lower}{[\code{\link{numeric}} or \code{\link{integer}}]\cr
The lower limits per dimension.}

\item{upper}{[\code{\link{numeric}} or \code{\link{integer}}]\cr
The upper limits per dimension.}

\item{blocks}{[\code{\link{integer}}]\cr
The number of blocks per dimension.}

\item{objective}{[\code{\link{character}(1)}]\cr
The name of the feature, which contains the objective values. The
default is \code{"y"}.}

\item{force}{[\code{\link{logical}(1)}]\cr
Only change this parameter IF YOU KNOW WHAT YOU ARE DOING! Per default
(\code{force = FALSE}), the function checks whether the total number of
cells that you are trying to generate, is below the (hard-coded) internal
maximum of 25,000 cells. If you set this parameter to \code{TRUE}, you
agree that you want to exceed that internal limit.\cr
Note: *Exploratory Landscape Analysis (ELA)* is only useful when you are
limited to a small budget (i.e., a small number of function evaluations)
and in such scenarios, the number of cells should also be kept low!}
}
\value{
[\code{\link{FeatureObject}}].
}
\description{
Create a \code{\link{FeatureObject}}, which will be used as input for all
  the feature computations.
}
\examples{
# (1a) create a feature object using X and y:
X = createInitialSample(n.obs = 500, dim = 3,
  control = list(init_sample.lower = -10, init_sample.upper = 10))
y = apply(X, 1, function(x) sum(x^2))
feat.object1 = createFeatureObject(X = X, y = y, 
  lower = -10, upper = 10, blocks = c(5, 10, 4))

# (1b) create a feature object using X and fun:
feat.object2 = createFeatureObject(X = X, 
  fun = function(x) sum(sin(x) * x^2),
  lower = -10, upper = 10, blocks = c(5, 10, 4))

# (1c) create a feature object using a data.frame:
feat.object3 = createFeatureObject(iris[,-5], blocks = 5, 
  objective = "Petal.Length")

# (2) have a look at the feature objects:
feat.object1
feat.object2
feat.object3

# (3) now, one could calculate features
calculateFeatureSet(feat.object1, "cm_conv", control = list(cm_conv.diag = TRUE))
calculateFeatureSet(feat.object2, "cm_grad")
library(plyr)
calculateFeatureSet(feat.object3, "cm_angle", control = list(cm_angle.show_warnings = FALSE))

}
