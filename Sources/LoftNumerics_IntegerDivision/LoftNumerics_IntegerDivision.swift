extension BinaryInteger {
    /// The quotient of `self` and `divisor` rounded down to the nearest
    /// integer.
    ///
    /// Gives different results from standard truncating integer division when
    /// the result is negative.
    public func flooringDiv(_ divisor: Self) -> Self {
        let truncatedResult = self / divisor
        if self.signum() != divisor.signum() &&
            (truncatedResult * divisor) != self
        {
            return truncatedResult - 1
        }
        return truncatedResult
    }

    /// The quotient of `self` and `divisor` rounded up to the nearest
    /// integer.
    ///
    /// Gives different results from standard truncating integer division when
    /// the result is positive.
    public func ceilingDiv(_ divisor: Self) -> Self {
        let truncatedResult = self / divisor
        if self.signum() == divisor.signum() &&
            (truncatedResult * divisor) != self
        {
            return truncatedResult + 1
        }
        return truncatedResult
    }
}