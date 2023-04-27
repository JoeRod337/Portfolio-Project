--select
--*
--from
--NashvilleHousing

--Cleaning Data in SQL Queries

--Standarize Date Format
--select
--SaleDateConverted, convert(date, SaleDate)
--from
--NashvilleHousing

--update NashvilleHousing
--set SaleDate = CONVERT(date,SaleDate)

--alter table NashvilleHousing
--add SaleDateConverted Date;

--update NashvilleHousing
--set SaleDateConverted = CONVERT(date, SaleDate)

--Populate Property Address Data

--select
--*
--from
--NashvilleHousing
--order by ParcelID

--select
--a.ParcelID, a. PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
--from
--NashvilleHousing a
--join NashvilleHousing b
--on a.ParcelID = b.ParcelID
--and a.[UniqueID ] <> b.[UniqueID ]
--where a.PropertyAddress is null

--update a
--set
--PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
--from
--NashvilleHousing a
--join NashvilleHousing b
--on a.ParcelID = b.ParcelID
--and a.[UniqueID ] <> b.[UniqueID ]
--where a.PropertyAddress is null

--select
--PropertyAddress
--from
--NashvilleHousing
--where
--PropertyAddress is null

--Breaking Out Address Into Individual Colums (Address, City, State)

--select
--SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) as Address
--from
--NashvilleHousing

--select
--SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1) as Address,
--SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, Len(PropertyAddress))as City

--from
--NashvilleHousing

--alter table NashvilleHousing
--add PropertySplitAddress Nvarchar (255);

--update NashvilleHousing
--set PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1)

--alter table NashvilleHousing
--add PropertySplitCity Nvarchar (255);

--update NashvilleHousing
--set PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, Len(PropertyAddress))

--Select
--*
--from
--NashvilleHousing

--select
--OwnerAddress
--from
--NashvilleHousing

--select
--PARSENAME(replace(OwnerAddress,',','.') , 1),
--PARSENAME(replace(OwnerAddress,',','.') , 2),
--PARSENAME(replace(OwnerAddress,',','.') , 3)
--from
--NashvilleHousing

--select
--PARSENAME(replace(OwnerAddress,',','.') , 3),
--PARSENAME(replace(OwnerAddress,',','.') , 2),
--PARSENAME(replace(OwnerAddress,',','.') , 1)
--from
--NashvilleHousing

--alter table NashvilleHousing
--add OwnerSplitAddress Nvarchar (255);

--update NashvilleHousing
--set OwnerSplitAddress = PARSENAME(replace(OwnerAddress,',','.') , 3)

--alter table NashvilleHousing
--add OwnerSplitCity Nvarchar (255);

--update NashvilleHousing
--set OwnerSplitCity = PARSENAME(replace(OwnerAddress,',','.') , 2)

--alter table NashvilleHousing
--add OwnerSplitState Nvarchar (255);

--update NashvilleHousing
--set OwnerSplitState = PARSENAME(replace(OwnerAddress,',','.') , 1)

--Select
--*
--from
--NashvilleHousing

--Change Y and N to Yes and No in "Sold as Vavant" Field

--select distinct(SoldAsVacant), count(SoldAsVacant)
--from
--NashvilleHousing
--group by SoldAsVacant
--order by 2

--select
--SoldAsVacant,
--case when SoldAsVacant = 'y' then 'Yes'
--when SoldAsVacant = 'n' then 'No'
--else SoldAsVacant
--end
--from
--NashvilleHousing

--update NashvilleHousing
--set SoldAsVacant = case when SoldAsVacant = 'y' then 'Yes'
--when SoldAsVacant = 'n' then 'No'
--else SoldAsVacant
--end

--select distinct(SoldAsVacant), count(SoldAsVacant)
--from
--NashvilleHousing
--group by SoldAsVacant
--order by 2

--Remove Duplicates

--with RowNumCTE as (
--select
--*,
--ROW_NUMBER() over(
--partition by ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference
--order by UniqueID) row_num

--from
--NashvilleHousing
--)
--Select *
--from
--RowNumCTE
--where row_num > 1

--with RowNumCTE as (
--select
--*,
--ROW_NUMBER() over(
--partition by ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference
--order by UniqueID) row_num

--from
--NashvilleHousing
--)
--delete
--from
--RowNumCTE
--where row_num > 1

--with RowNumCTE as (
--select
--*,
--ROW_NUMBER() over(
--partition by ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference
--order by UniqueID) row_num

--from
--NashvilleHousing
--)
--select *
--from
--RowNumCTE
--where row_num > 1

--Delete Unused Columns

select *
from
NashvilleHousing

alter table NashvilleHousing
drop column OwnerAddress, TaxDistrict, PropertyAddress, SaleDate