//
//  Constants.swift
//  InDoor-Admin
//
//  Created by Ahmed on 16/06/2023.
//

import Foundation

class Constants {
    static let rootUrl = "https://mad43-sv-ios1.myshopify.com/admin/api/2023-04"
    static let urlExtension = ".json"
    static let urlQueryProducts = "products"
    static let urlQueryCollections = "collections"
    static let urlQueryImages = "images"
    static let accessTokenHeader = "X-Shopify-Access-Token"
    static let accessKey = "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"
    static let selectColor = "Select Color"
    static let selectSize = "Select Size"
    static let selectOptions = "Select Options"
    static let notAvailable = "Not Available"
    static let inStock = "In Stock"
    static let ok = "ok"
    static let error = "Error"
    static let add = "Add"
    static let edit = "Edit"
    static let size = "Size"
    static let color = "Color"
    static let warning = "Warning"
    static let delete = "Delete"
    static let cancel = "Cancel"
    static let notice = "Notice"
    static let discard = "Discard"
    static let save = "Save"
    static let checkMarkDiamondImage = "checkmark.diamond.fill"
    static let checkMarkSeal = "checkmark.seal"
    static let pencilEditImage = "pencil.line"
    static let selectSizeAndColor = "Please select color and size first"
    static let enterValidNumber = "Please enter valid number"
    static let enterValidPrice = "Please enter a valid price"
    static let enterValidQuantity = "Please enter a valid quantity number"
    static let zeroPrice = "Price can't be set to zero"
    static let validPrice = "Please enter valid Price"
    static let emptyDescription = "Description Can't be Empty"
    static let duplicatedVariant = "This variant is already available"
    static let duplicatedImage = "This image is already available"
    static let duplicatedProduct = "This product is already available"
    static let atLeastOneImage = "Please add at least one image"
    static let atLeastOneVariant = "Please enter at least one variant"
    static let wrongPriceOrQuantity = "Wrong input for price or quantity"
    static let emptyFields = "Please fill all fields"
    static let enterImageURL = "Please enter image URL"
    static let confirmDeleteImage = "Are you sure you want to delete this image?"
    static let confirmDeleteProduct = "Are you sure you want to delete this product?"
    static let deleteVariantInsteadOfZero = "Quantity set to zero do you want to delete this variant instead?"
    static let deleteProductInsteadOfVariant = "Deleting the last vatiant will delete the whole product\n are you sure you want to delete the product ?"
    static let imageHandlingQuery = "This image hasn't been saved yet \n click Discard to discard image and continue \n click save image to save the image and continue \n click cancel to cancel"
    static let variantHandlingQuery = "This variant hasn't been saved yet \n click Discard to discard variant and continue \n click save to save the variant and continue \n click cancel to cancel"
}