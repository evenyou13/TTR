c
c   TTR: Technical Trading Rules
c
c   Copyright (C) 2007-2013  Joshua M. Ulrich
c
c   This program is free software: you can redistribute it and/or modify
c   it under the terms of the GNU General Public License as published by
c   the Free Software Foundation, either version 2 of the License, or
c   (at your option) any later version.
c
c   This program is distributed in the hope that it will be useful,
c   but WITHOUT ANY WARRANTY; without even the implied warranty of
c   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
c   GNU General Public License for more details.
c
c   You should have received a copy of the GNU General Public License
c   along with this program.  If not, see <http://www.gnu.org/licenses/>.
c

c     Calculate Simple Moving Average (SMA)
c
c http://www.fmlabs.com/reference/SimpleMA.htm
c http://www.equis.com/Customer/Resources/TAAZ/Default.aspx?c=3&p=74
c http://linnsoft.com/tour/techind/movAvg.htm
c http://stockcharts.com/education/IndicatorAnalysis/indic_movingAvg.html
c 
c     http://en.wikipedia.org/wiki/Moving_average
c     I think Wikipedia is wrong. The MA shouldn't have
c     anything to do with _tomorrow's_ value.
c
c      subroutine sma(ia, lia, n, oa, loa)
c
c      integer lia, n, loa, i
c      double precision ia(lia), oa(loa)
c
c      do 10 i=n+1,lia
c
c        oa(i) = oa(i-1) + (ia(i) - ia(i-n))/n
c      
c   10 continue
c      end

c-----------------------------------------------------------------------c
c
c     Calculate Exponential Moving Average (EMA)
c
c http://www.fmlabs.com/reference/ExpMA.htm
c http://www.equis.com/Customer/Resources/TAAZ/Default.aspx?c=3&p=74
c http://linnsoft.com/tour/techind/movAvg.htm
c http://stockcharts.com/education/IndicatorAnalysis/indic_movingAvg.html
c
c     Thanks to Jeff Ryan for the Fortran implementation,
c     and more importantly, the encouragement!
c
c     ia    : input array
c     lia   : length of input array
c     n     : number of periods
c     oa    : output array
c     loa   : length of output array
c     ratio : weighting/decay ratio
c
      subroutine ema(ia, lia, n, oa, loa, ratio)

      integer lia, n, loa, i
      double precision ia(lia), oa(loa)
      double precision ratio

      do 10 i=n+1,lia

        oa(i) = ia(i) * ratio + oa(i-1) * (1-ratio)

   10 continue
      end

c-----------------------------------------------------------------------c
c
c     Calculate Elastic, Volume-Weighted Moving Average (EVWMA)
c
c http://linnsoft.com/tour/techind/evwma.htm
c  
c     ip    : input array, price
c     iv    : input array, volume
c     ivs   : input array, volume sum
c     lia   : length of input arrays
c     n     : number of periods
c     oa    : output array
c     loa   : length of output array
c
      subroutine evwma(ip, iv, ivs, lia, n, oa, loa)

      integer lia, n, loa, i
      double precision ip(lia), iv(lia), ivs(lia), oa(loa)

      do 10 i=n+1,lia

        oa(i) = ( (ivs(i) - iv(i)) * oa(i-1) + iv(i) * ip(i) ) / ivs(i)

   10 continue
      end
