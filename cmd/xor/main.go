package main

import (
	"fmt"
	"log"

	"github.com/mattn/tensai"
	"github.com/mattn/tensai/layer"
	"github.com/mattn/tensai/loss"
	"github.com/mattn/tensai/model"
	"github.com/mattn/tensai/optim"
)

func main() {
	inputs := mustMatrix(4, 2, []float32{
		0, 0,
		0, 1,
		1, 0,
		1, 1,
	})
	targets := mustMatrix(4, 1, []float32{0, 1, 1, 0})

	net := model.NewSequential()
	net.Add(layer.NewDense(8))
	net.Add(&layer.Tanh{})
	net.Add(layer.NewDense(1))
	net.Add(&layer.Sigmoid{})

	if err := net.Compile(2, loss.MeanSquaredError{}, optim.NewAdam(0.05)); err != nil {
		log.Fatal(err)
	}
	if err := net.Fit(inputs, targets, 5000); err != nil {
		log.Fatal(err)
	}

	predictions, err := net.Predict(inputs)
	if err != nil {
		log.Fatal(err)
	}

	fmt.Println("XOR predictions")
	for row := range inputs.Rows {
		fmt.Printf(
			"%.0f XOR %.0f = %.4f (expected %.0f)\n",
			inputs.At(row, 0),
			inputs.At(row, 1),
			predictions.At(row, 0),
			targets.At(row, 0),
		)
	}
}

func mustMatrix(rows, cols int, values []float32) *tensai.Matrix {
	matrix, err := tensai.NewMatrixFromSlice(rows, cols, values)
	if err != nil {
		log.Fatal(err)
	}
	return matrix
}
