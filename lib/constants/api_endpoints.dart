const baseUrl = "https://www.themealdb.com/api/json/v1/1/";
const allMeals = "https://www.themealdb.com/api/json/v1/1/categories.php";
const mealDetail = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=";
const randomMeal = "https://www.themealdb.com/api/json/v1/1/random.php";
const mealCategories = "https://www.themealdb.com/api/json/v1/1/categories.php";
const filterMealsByCategory = "https://www.themealdb.com/api/json/v1/1/filter.php?c=";


//Search meal by name
//https://www.themealdb.com/api/json/v1/1/search.php?s=Arrabiata
//List all meals by first letter
//https://www.themealdb.com/api/json/v1/1/search.php?f=a
//Lookup full meal details by id
//https://www.themealdb.com/api/json/v1/1/lookup.php?i=52772
//Lookup a single random meal
//https://www.themealdb.com/api/json/v1/1/random.php
//Lookup a selection of 10 random meals (only available to $2+ Patreon supporters)
//https://www.themealdb.com/api/json/v1/1/randomselection.php
//List all meal categories
//https://www.themealdb.com/api/json/v1/1/categories.php
//List all Categories, Area, Ingredients
//https://www.themealdb.com/api/json/v1/1/list.php?c=list
//https://www.themealdb.com/api/json/v1/1/list.php?a=list
//https://www.themealdb.com/api/json/v1/1/list.php?i=list