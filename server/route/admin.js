const express = require('express');
const adminRouter = express.Router();
const admin = require('../middleware/admin');
const { Product } = require('../models/product');
const Order = require('../models/order');

//add product
adminRouter.post('/admin/add-product', admin, async (req, res) => {
    try {
        const { name, description, images, quantity, price, category } = req.body;
        let product = new Product({
            name,
            description,
            images,
            quantity,
            price,
            category,
        });
        product = await product.save();
        res.json(product);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

//get products
adminRouter.get("/admin/get-products", admin, async (req, res) => {
    try {
        const products = await Product.find({});
        res.json(products);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

//delete product
adminRouter.post("/admin/delete-product", admin, async (req, res) => {
    try {
        const { id } = req.body;
        let product = await Product.findByIdAndDelete(id);
        res.json(product);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

adminRouter.get("/admin/get-orders", admin, async (req, res) => {
    try {
        const orders = await Order.find({});
        res.json(orders);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

adminRouter.post("/admin//admin/change-order-status", admin, async (req, res) => {
    try {
        const { id, status } = req.body;
        let order = await Order.findById(id);
        order.status = status;
        order = await order.save();
        res.json(order);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

adminRouter.get("/admin/analytics", admin, async (req, res) => {
    try {
        const orders = await Order.find({});
        let totalEarnings = 0;

        for(let i=0; i<orders.length; i++) {
            for(let j=0; i<orders[i].products.length; j++) {
                totalEarnings += orders[i].products[j].quantity * orders[i].products[j].product.price;
            }
        }
        //category wise order fetch
        let mobileEarnings = await fetchCategoryWiseProducts('Mobiles');
        let laptopEarnings = await fetchCategoryWiseProducts('Laptops');
        let furnitureEarnings = await fetchCategoryWiseProducts('Furniture');
        let bookEarnings = await fetchCategoryWiseProducts('Books');
        let clothingEarnings = await fetchCategoryWiseProducts('Clothing');

        let earnings = {
            totalEarnings,
            mobileEarnings,
            laptopEarnings,
            furnitureEarnings,
            bookEarnings,
            clothingEarnings,
        };

        res.json(earnings);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

async function fetchCategoryWiseProducts(category) {
    let earnings = 0;
    let categoryOrders = await Order.find({
        'products.product.category': category,
    });

    for(let i=0; i<categoryOrders.length; i++) {
        for(let j=0; i<categoryOrders[i].products.length; j++) {
            totalEarnings += categoryOrders[i].products[j].quantity * categoryOrders[i].products[j].product.price;
        }
    }
    return earnings;
}

module.exports = adminRouter;
