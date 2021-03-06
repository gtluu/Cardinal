
facet.image <- function(args, formula, obj,
	facets, groups, superpose, strip, key,
	normalize.image, contrast.enhance, smooth.image, ...,
	xlab, xlim, ylab, ylim, zlab, zlim, asp,
	layout, byrow, dark, col, colorscale, colorkey,
	alpha.power, subset, add)
{
	dots <- list(...)
	e <- environment(formula)
	x <- args$rhs[[1]]
	y <- args$rhs[[2]]
	is3d <- length(args$rhs) == 3L
	if ( is3d ) {
		z <- args$rhs[[3]]
	} else {
		z <- NULL
	}
	values <- args$lhs
	n <- nrow(coord(obj))
	if ( any(lengths(values) != n) || length(x) != n || length(y) != n )
		.stop("variable lengths differ")
	if ( is3d && length(z) != n )
		.stop("variable lengths differ")
	if ( superpose && !is.null(groups) )
		.stop("cannot specify 'superpose' and 'groups' in same call")
	more_dims <- length(coord(obj)) > length(args$rhs)
	if ( more_dims ) {
		wh <- which(coordnames(obj) %in% names(args$rhs))
		dpages <- .format.data.labels(coord(obj)[,-wh,drop=FALSE])
		dpages <- factor(dpages, levels=unique(dpages))
		has_dpages <- TRUE
	} else if ( !is3d ) {
		dpages <- run(obj)
		if ( length(runNames(obj)) > 1L ) {
			has_dpages <- TRUE
		} else {
			has_dpages <- FALSE
		}
	} else {
		dpages <- rep_len(factor(1), n)
		has_dpages <- FALSE
	}
	if ( !is.null(groups) ) {
		has_groups <- TRUE		
	} else {
		if ( !is.numeric(values[[1]]) ) {
			if ( length(values) > 1L )
				.stop("multiple categorical variables in lhs of formula")
			groups <- as.factor(values[[1]])
			has_groups <- TRUE
		} else {
			groups <- rep_len(factor(1), n)
			has_groups <- FALSE
		}
	}
	if ( !is.null(subset) ) {
		x <- x[subset]
		y <- y[subset]
		z <- z[subset]
		values <- lapply(values, "[", subset)
		groups <- droplevels(groups[subset])
		dpages <- droplevels(dpages[subset])
	}
	if ( !is.null(facets) ) {
		if ( !is.data.frame(facets) )
			facets <- as.data.frame(facets)
		facets[] <- lapply(facets, function(fc) {
			if ( is.factor(fc) ) {
				droplevels(fc)
			} else {
				factor(fc, levels=unique(fc))
			}
		})
		has_facets <- TRUE
	} else {
		facets <- rep_len(factor(1), length(values))
		facets <- as.data.frame(facets)
		has_facets <- FALSE
	}
	facet_levels <- unique(facets)
	facet_levels <- lapply(seq_len(nrow(facet_levels)),
		function(i) facet_levels[i,,drop=FALSE])
	raw_values <- unlist(values, use.names=FALSE)
	if ( is.numeric(raw_values) ) {
		raw_valrange <- range(raw_values, na.rm=TRUE)
	} else {
		raw_valrange <- c(NA, NA)
	}
	if ( gridded(obj) ) {
		rx <- resolution(obj)[names(args$rhs)[1]]
		ry <- resolution(obj)[names(args$rhs)[2]]
		if ( is3d ) {
			rz <- resolution(obj)[names(args$rhs)[3]]
			res <- c(rx, ry, rz)
			dim <- .getDimsFromResolution(list(x=x, y=y, z=z), res)
		} else {
			res <- c(rx, ry)
			dim <- .getDimsFromResolution(list(x=x, y=y), res)
		}
	} else {
		ux <- sort(unique(x))
		uy <- sort(unique(y))
		if ( length(ux) == 1L || length(uy) == 1L )
			.stop("can't estimate reasonable raster dimensions")
		rx <- min(diff(ux), na.rm=TRUE)
		ry <- min(diff(uy), na.rm=TRUE)
		if ( is3d )
			rz <- min(diff(sort(unique(z))), na.rm=TRUE)
		res <- NULL
		dim <- NULL
	}
	rx <- ifelse(is.finite(rx), rx, 1)
	ry <- ifelse(is.finite(ry), ry, 1)
	if ( is3d )
		rz <- ifelse(is.finite(rz), rz, 1)
	if ( missing(xlab) )
		xlab <- names(args$rhs)[1]
	if ( missing(ylab) )
		ylab <- names(args$rhs)[2]
	if ( missing(zlab) ) 
		zlab <- names(args$rhs)[3]
	xrange <- range(x, na.rm=TRUE)
	yrange <- range(y, na.rm=TRUE)
	valrange <- c(NA, NA)
	normalize.image <- normalize.image.method(normalize.image)
	contrast.enhance <- contrast.enhance.method(contrast.enhance)
	smooth.image <- smooth.image.method(smooth.image)
	plotnew <- !add
	add <- FALSE
	facets.out <- list()
	for ( p in levels(dpages) ) {
		for ( f in facet_levels ) {
			facet_ids <- subset_rows(facets, f)
			for ( i in facet_ids ) {
				vals <- values[[i]]
				v <- names(values)[i]
				if ( has_groups || superpose || !is.numeric(vals) ) {
					if ( has_groups ) {
						levels <- levels(groups)
					} else if ( superpose ) {
						levels <- na.omit(unique(names(values)))
					} else {
						levels <- na.omit(unique(vals))
					}
					nlevels <- length(levels)
					if ( is.function(col) ) {
						colors <- col(nlevels)
					} else {
						colors <- col
					}
					if ( length(colors) != nlevels )
						colors <- rep_len(colors, nlevels)
					has_cats <- TRUE
				} else {
					if ( is.function(colorscale) ) {
						colors <- colorscale(100)
					} else {
						colors <- colorscale
					}
					has_cats <- FALSE
				}
				if ( !is.numeric(vals) )
					vals <- as.factor(vals)
				layers <- list()
				for ( g in levels(groups) ) {
					subscripts <- dpages == p
					gi <- groups[subscripts]
					xi <- x[subscripts]
					yi <- y[subscripts]
					zi <- z[subscripts]
					ti <- vals[subscripts]
					ti[gi != g] <- NA
					if ( has_cats ) {
						if ( has_groups ) {
							cat <- g
						} else if ( superpose ) {
							cat <- v
						} else {
							cat <- NULL
						}
						cols <- setNames(colors, levels)
						cols <- cols[cat]
						if ( !is.null(cat) && is.numeric(vals) )
							cols <- alpha.colors(cols, 100, alpha.power=alpha.power)
					} else {
						cols <- colors
					}
					if ( is3d ) {
						ti <- normalize.image(contrast.enhance(ti))
						if ( !all(is.na(ti)) )
							valrange <- range(valrange, ti, na.rm=TRUE)
						layers[[length(layers) + 1L]] <- list(
							x=xi, y=yi, z=zi, values=ti, col=cols,
							dpage=p, facet=f, group=g, add=add)
					} else {
						tproj <- projectToRaster(xi, yi, ti, dim=dim, res=res)
						tproj <- structure(tproj, range=raw_valrange, resolution=res)
						tproj <- normalize.image(smooth.image(contrast.enhance(tproj)))
						xj <- seq(xrange[1L], xrange[2L], length.out=dim(tproj)[1])
						yj <- seq(yrange[1L], yrange[2L], length.out=dim(tproj)[2])
						if ( !all(is.na(tproj)) )
							valrange <- range(valrange, tproj, na.rm=TRUE)
						layers[[length(layers) + 1L]] <- list(
							x=xj, y=yj, values=tproj, col=cols,
							dpage=p, facet=f, group=g, add=add)
					}
					add <- TRUE
				}
				last <- i == max(facet_ids)
				if ( !superpose || last ) {
					text <- character()
					if ( length(values) > 1L || has_facets ) {
						if ( has_facets ) {
							text <- c(sapply(f, as.character), text)
						} else if ( !superpose ) {
							text <- c(v, text)
						}
					}
					if ( has_dpages )
						text <- c(p, text)
					attr(layers, "strip") <- list(
						strip=strip, text=text)
					if ( has_cats ) {
						attr(layers, "key") <- list(
							key=key, text=levels, fill=colors)
					} else {
						attr(layers, "colorkey") <- list(
							colorkey=colorkey,
							text=c(NA, NA), # populate later
							col=colors)
					}
				}
				facets.out <- c(facets.out, list(layers))
				add <- superpose
			}
			add <- FALSE
		}
		add <- FALSE
	}
	if ( missing(layout) )
		layout <- TRUE
	if ( missing(byrow) )
		byrow <- TRUE
	layout <- list(layout=layout, byrow=byrow)
	if ( missing(xlim) || is.null(xlim) )
		xlim <- xrange + rx * c(-0.5, 0.5)
	if ( missing(ylim) || is.null(ylim) )
		ylim <- yrange + ry * c(-0.5, 0.5)
	if ( missing(zlim) || is.null(zlim) ) {
		if ( is3d ) {
			zlim <- range(z, na.rm=TRUE) + rz * c(-0.5, 0.5)
		} else {
			zlim <- valrange
		}
	}
	if ( is3d ) {
		par <- list(
			xlab=xlab, ylab=ylab, zlab=zlab,
			xlim=xlim, ylim=ylim, zlim=zlim,
			alpha.power=alpha.power,
			asp=asp)
	} else {
		par <- list(
			xlab=xlab, ylab=ylab,
			xlim=xlim, ylim=ylim, zlim=zlim,
			asp=asp)
	}
	out <- list(
		facets=facets.out,
		fids=do.call("rbind", facet_levels),
		dpages=levels(dpages),
		groups=levels(groups),
		subset=subset,
		coordnames=names(args$rhs),
		valrange=valrange,
		is3d=is3d, layout=layout,
		add=!plotnew,
		par=c(par, dots))
	if ( !missing(dark) )
		out$dark <- dark
	class(out) <- "facet.image"
	out
}

print.facet.image <- function(x, ...) {
	obj <- .update.par(x, ...)
	ck <- lapply(obj$facets, attr, "colorkey")
	no_ck <- sapply(ck, function(y) is.null(y) || isFALSE(y$colorkey))
	if ( all(no_ck) ) {
		padding <- 0
	} else {
		padding <- 2
	}
	if ( isTRUE(obj$layout$layout) ) {
		layout <- .auto.layout(obj, right=padding,
			byrow=obj$layout$byrow, par=obj$par)
	} else if ( is.numeric(obj$layout$layout) ) {
		layout <- .setup.layout(obj$layout$layout, right=padding,
			byrow=obj$layout$byrow, par=obj$par)
	} else {
		layout <- obj$layout
	}
	if ( isTRUE(obj$dark) || getOption("Cardinal.dark") ) {
		darkmode()
	} else if ( isFALSE(obj$dark) ) {
		lightmode()
	}
	if ( obj$add )
		.next.figure(last=TRUE)
	if ( obj$is3d ) {
		colorkeyrange <- obj$valrange
	} else {
		colorkeyrange <- obj$par$zlim
		obj$par$ylim <- rev(obj$par$ylim)
	}
	for ( facet in obj$facets ) {
		for ( layer in facet ) {
			new <- !layer$add
			if ( obj$is3d ) {
				args <- c(list(
					x=layer$x, y=layer$y, z=layer$z,
					values=layer$values, col=layer$col,
					add=layer$add), obj$par)
				do.call("points3d", args)
			} else {
				if ( new ) {
					par <- obj$par[-which(names(obj$par) == "zlim")]
					if ( !"xaxs" %in% names(par) )
						par$xaxs <- "i"
					if ( !"yaxs" %in% names(par) )
						par$yaxs <- "i"
					if ( obj$add ) {
						.next.figure(layout)
					} else {
						nil <- c(list(x=NA, y=NA, type='n'), par)
						do.call("plot", nil)
					}
				}
				if ( !allmissing(layer$values) ) {
					args <- c(list(
						x=layer$x, y=layer$y, z=layer$values,
						col=layer$col, add=TRUE), obj$par)
					if ( isTRUE(args$useRaster) )
						args$z <- args$z[,ncol(args$z):1L,drop=FALSE]
					do.call("image", args)
				}
			}
		}
		strip <- attr(facet, "strip")
		if ( !is.null(strip) )
			.draw.strip.labels(strip$strip, strip$text)
		key <- attr(facet, "key")
		if ( !is.null(key) )
			.draw.key(key$key, key$text, key$fill)
		colorkey <- attr(facet, "colorkey")
		if ( !is.null(colorkey) )			
			.draw.colorkey(colorkey$colorkey,
				colorkeyrange, colorkey$col, layout)
	}
	.Cardinal$lastplot <- x
	invisible(x)
}

