#include <stdio.h>
#include <stdbool.h>
#include <math.h>

#define MAX_MODELS 1024
#define MAX_VERTS 8192
#define MAX_FACES 16384


#define DBL_EPSILON 2.2204460492503131e-16
#define MATH_HUGE 3.402823466e+38

typedef struct Vector {
    float x;
    float y;
    float z;
} Vector;

typedef struct Matrix4x4 {
	float m_0_0;
	float m_1_0;
	float m_2_0;
	float m_3_0;

	float m_0_1;
	float m_1_1;
	float m_2_1;
	float m_3_1;

	float m_0_2;
	float m_1_2;
	float m_2_2;
	float m_3_2;

	float m_0_3;
	float m_1_3;
	float m_2_3;
	float m_3_3;
} Matrix4x4;

typedef struct TraceResult {
    bool hit;
	float dist;
    Vector pos;
} TraceResult;

typedef struct TraceResultObject {
    bool hit;
	float dist;
    Vector pos;
	Vector normal;
} TraceResultObject;

typedef struct UV {
	float u;
	float v;
} UV;

typedef struct Face {
	unsigned long v1i;
	unsigned long v2i;
	unsigned long v3i;

	unsigned long v1ui;
	unsigned long v2ui;
	unsigned long v3ui;
} Face;

// later later
typedef struct Model {
	unsigned long vertCount;
	unsigned long uvCount;
	unsigned long faceCount;

	Vector 	vertList[MAX_VERTS];
	UV 		uvList[MAX_VERTS];

	Vector 	normalList[MAX_FACES];
	Face 	faceList[MAX_FACES];
} Model;


Model mdlList[MAX_MODELS];

void declare_model(unsigned int index, unsigned long vertCount, unsigned long uvCount, unsigned long faceCount) {
	Model newMdl;
	newMdl.vertCount = vertCount;
	newMdl.uvCount = uvCount;
	newMdl.faceCount = faceCount;

	mdlList[index] = newMdl;
};

inline void vector_copy(Vector* result, Vector* const cpy) {
	(*result).x = cpy->x;
	(*result).y = cpy->y;
	(*result).z = cpy->z;
};


inline void vector_sub(Vector* vec1, Vector* const vec2) {
    (*vec1).x = vec1->x - vec2->x;
    (*vec1).y = vec1->y - vec2->y;
    (*vec1).z = vec1->z - vec2->z;
};

inline void vector_add(Vector* vec1, Vector* const vec2) {
    (*vec1).x = vec1->x + vec2->x;
    (*vec1).y = vec1->y + vec2->y;
    (*vec1).z = vec1->z + vec2->z;
};

inline void vector_neg(Vector* vec) {
	(*vec).x = -vec->x;
	(*vec).y = -vec->y;
	(*vec).z = -vec->z;
}

inline void vector_neg_r(Vector* out, Vector* const vec) {
	(*out).x = -vec->x;
	(*out).y = -vec->y;
	(*out).z = -vec->z;
}

inline void vector_mul_f(Vector* vec1, float s) {
    (*vec1).x = vec1->x * s;
    (*vec1).y = vec1->y * s;
    (*vec1).z = vec1->z * s;
};

inline void vector_sub_r(Vector* result, Vector* const vec1, Vector* const vec2) {
    (*result).x = vec1->x - vec2->x;
    (*result).y = vec1->y - vec2->y;
    (*result).z = vec1->z - vec2->z;
};

inline void vector_add_r(Vector* result, Vector* const vec1, Vector* const vec2) {
    (*result).x = vec1->x + vec2->x;
    (*result).y = vec1->y + vec2->y;
    (*result).z = vec1->z + vec2->z;
};


inline void vector_cross(Vector* result, Vector* const vec1, Vector* const vec2) {
    (*result).x = vec1->y * vec2->z - vec1->z * vec2->y;
    (*result).y = vec1->z * vec2->x - vec1->x * vec2->z;
    (*result).z = vec1->x * vec2->y - vec1->y * vec2->x;
};


inline void vector_mul_matrix(Vector* result, Vector* const vec1, Matrix4x4* const mat1) {
    (*result).x = (mat1->m_0_0 * vec1->x) + (mat1->m_1_0 * vec1->y) + (mat1->m_2_0 * vec1->z) + (mat1->m_3_0 * 1);
    (*result).y = (mat1->m_0_1 * vec1->x) + (mat1->m_1_1 * vec1->y) + (mat1->m_2_1 * vec1->z) + (mat1->m_3_1 * 1);
    (*result).z = (mat1->m_0_2 * vec1->x) + (mat1->m_1_2 * vec1->y) + (mat1->m_2_2 * vec1->z) + (mat1->m_3_2 * 1);
};


inline void vector_mul_matrix_rot(Vector* result, Vector* const vec1, Matrix4x4* const mat1) {
    (*result).x = (mat1->m_0_0 * vec1->x) + (mat1->m_1_0 * vec1->y) + (mat1->m_2_0 * vec1->z);
    (*result).y = (mat1->m_0_1 * vec1->x) + (mat1->m_1_1 * vec1->y) + (mat1->m_2_1 * vec1->z);
    (*result).z = (mat1->m_0_2 * vec1->x) + (mat1->m_1_2 * vec1->y) + (mat1->m_2_2 * vec1->z);
};

float vector_dot(Vector* const vec1, Vector* const vec2) {
    return vec1->x * vec2->x + vec1->y * vec2->y + vec1->z * vec2->z;
};

float vector_normalize(Vector* vec1) {
	float length = sqrt(pow(vec1->x, 2) + pow(vec1->y, 2) + pow(vec1->z, 2));

	(*vec1).x = vec1->x / length;
	(*vec1).y = vec1->y / length;
	(*vec1).z = vec1->z / length;
};

void vector_print(Vector* const vec) {
	printf("Vector(%.2f, %.2f, %.2f)", vec->x, vec->y, vec->z);
};



void model_push_vertex(unsigned int index, unsigned int vertIndex, Vector vertex) {
	Vector cpy;
	vector_copy(&cpy, &vertex);


	mdlList[index].vertList[vertIndex] = cpy;
};

void model_push_uv(unsigned int index, unsigned int uvIndex, UV uv) {
	mdlList[index].uvList[uvIndex] = uv;
};

void model_push_normal(unsigned int index, unsigned int normIndex, Vector normal) {
	mdlList[index].normalList[normIndex] = normal;
};

void model_push_face(unsigned int index, unsigned int faceIndex, Face face) {
	mdlList[index].faceList[faceIndex] = face;
};


// https://github.com/excessive/cpml/blob/master/modules/intersect.lua
TraceResult rayIntersectsTriangle(Vector rayPos, Vector rayDir, Vector v1, Vector v2, Vector v3, bool backface_cull) {
	//vector_neg(&v1);
	//vector_neg(&v2);
	//vector_neg(&v3);


    Vector e1;
	vector_sub_r(&e1, &v2, &v1);
    //Vector e2 = vector_sub(v3, v1)

	Vector e2;
	vector_sub_r(&e2, &v3, &v1);

	Vector h;
	vector_cross(&h, &rayDir, &e2);


	float a = vector_dot(&h, &e1);

	// if a is negative, ray hits the backface
	if(backface_cull && a < 0) {
		TraceResult out;
		out.hit = false;
		return out;
	};

	// if a is too close to 0, ray does not intersect triangle
	if(fabs(a) <= DBL_EPSILON) {
		TraceResult out;
		out.hit = false;
		return out;
	}

	float f = 1.0f / a;

	Vector s;
	vector_sub_r(&s, &rayPos, &v1);

	float u = vector_dot(&s, &h) * f;

	// ray does not intersect triangle
	if(u < 0.0f || u > 1.0f) {
		TraceResult out;
		out.hit = false;
		return out;
	}

	Vector q;
	vector_cross(&q, &s, &e1);

	float v = vector_dot(&rayDir, &q) * f;

	// ray does not intersect triangle
	if(v < 0.0f || u + v > 1.0f) {
		TraceResult out;
		out.hit = false;
		return out;
	}

	// at this stage we can compute t to find out where
	// the intersection point is on the line
	float t = vector_dot(&q, &e2) * f;

	// return position of intersection and distance from ray origin
	if(t >= DBL_EPSILON) {
		TraceResult out;

		Vector hp;
		vector_copy(&hp, &rayDir);
		vector_mul_f(&hp, t); // rayDir * t
		vector_add(&hp, &rayPos);

		//vector_neg(&hp);
		out.pos = hp;
		out.dist = t;
		out.hit = true;

		return out;
	}

	TraceResult out;
	out.hit = false;

	return out;
}


TraceResultObject rayIntersectsModel(Vector rayPos, Vector rayDir, Matrix4x4 mdlMatrix, unsigned int mdlIndex, bool backface_cull, float minDistIn, bool normInvert) {
	Model* modelNfo = &mdlList[mdlIndex];

	float minDist = minDistIn;
	bool hit = false;
	Vector hitPos;
	Vector hitNormal;


	int i;
	for(i = 0; i <= modelNfo->faceCount; i++) {
		Face* currFace = &modelNfo->faceList[i];
		Vector* currNormo = &modelNfo->normalList[i];

		Vector currNorm;
		//vector_copy(&currNorm, currNormo);
		vector_mul_matrix_rot(&currNorm, currNormo, &mdlMatrix);
		vector_normalize(&currNorm);


		Vector* vec1o = &modelNfo->vertList[currFace->v1i];
		Vector* vec2o = &modelNfo->vertList[currFace->v2i];
		Vector* vec3o = &modelNfo->vertList[currFace->v3i];

		Vector vec1;
		//vector_copy(&vec1, vec1o);
		vector_mul_matrix(&vec1, vec1o, &mdlMatrix);

		Vector vec2;
		//vector_copy(&vec2, vec2o);
		vector_mul_matrix(&vec2, vec2o, &mdlMatrix);

		Vector vec3;
		//vector_copy(&vec3, vec3o);
		vector_mul_matrix(&vec3, vec3o, &mdlMatrix);



		UV* uv1 = &modelNfo->uvList[currFace->v1ui];
		UV* uv2 = &modelNfo->uvList[currFace->v2ui];
		UV* uv3 = &modelNfo->uvList[currFace->v3ui];

		Vector rPosCopy;
		vector_copy(&rPosCopy, &rayPos);

		Vector rDirCopy;
		vector_copy(&rDirCopy, &rayDir);



		TraceResult trOut;
		
		if(normInvert == true) {
			trOut = rayIntersectsTriangle(rayPos, rayDir, vec3, vec2, vec1, backface_cull);
		} else {
			trOut = rayIntersectsTriangle(rayPos, rayDir, vec1, vec2, vec3, backface_cull);
		}

		if(!trOut.hit) {
			continue;
		}

		if(trOut.dist < minDist) {
			if(!hit) {
				hit = true;
			}
			hitPos = trOut.pos;
			hitNormal = currNorm;
			minDist = trOut.dist;
		}
	}

	TraceResultObject out;
	out.hit = hit;
	out.dist = minDist;
	out.pos = hitPos;
	
	if(normInvert == true) {
		vector_neg(&hitNormal);
	}

	out.normal = hitNormal;

	return out;
};